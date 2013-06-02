package h3d;

// use left-handed coordinate system, more suitable for 2D games X=0,Y=0 at screen top-left and Z towards user

class Camera {
	
	public var zoom : Float;
	public var ratio : Float;
	public var fov : Float;
	public var zNear : Float;
	public var zFar : Float;
	
	public var rightHanded : Bool;
	public var orthographic : Bool;
	
	public var mproj : Matrix;
	public var mcam : Matrix;
	public var m : Matrix;
	
	public var pos : Vector;
	public var up : Vector;
	public var target : Vector;
	public var viewport : Vector;
	var minv : Matrix;
	var needInv : Bool;

	public function new( fov = 60., zoom = 1., ratio = 1.333333, zNear = 0.02, zFar = 4000., rightHanded = false ) {
		this.fov = fov;
		this.zoom = zoom;
		this.ratio = ratio;
		this.zNear = zNear;
		this.zFar = zFar;
		this.rightHanded = rightHanded;
		pos = new Vector(2, 3, 4);
		up = new Vector(0, 0, 1);
		target = new Vector(0, 0, 0);
		m = new Matrix();
		mcam = new Matrix();
		viewport = new Vector(0, 0);
		update();
	}
	
	public function clone() {
		var c = new Camera(fov, zoom, ratio, zNear, zFar, rightHanded);
		c.pos = pos.clone();
		c.up = up.clone();
		c.target = target.clone();
		c.update();
		return c;
	}

	/**
		Returns the inverse of the camera matrix view and projection. Cache the result until the next update().
	**/
	public function getInverseViewProj() {
		if( minv == null ) minv = new h3d.Matrix();
		if( needInv ) {
			minv.inverse(m);
			needInv = false;
		}
		return minv;
	}

	/**
		Transforms a 2D screen position into the 3D one according to the current camera.
		The screenX and screenY values must be in the [-1,1] range.
		The camZ value represents the normalized z in the frustum in the [0,1] range.
		[unproject] can be used to get the ray from the camera position to a given screen position by using two different camZ values.
		For instance the 3D ray between unproject(0,0,0) and unproject(0,0,1) is the center axis of the 3D frustum.
	**/
	public function unproject( screenX : Float, screenY : Float, camZ ) {
		var p = new h3d.Vector(screenX, screenY, camZ);
		p.project(getInverseViewProj());
		return p;
	}
	
	public function update() {
		var az = pos.sub(target);
		az.normalize();
		var ax;
		if( rightHanded )
			ax = up.cross(az);
		else
			ax = az.cross(up);
		ax.normalize();
		if( ax.length() == 0 ) {
			ax.x = az.y;
			ax.y = az.z;
			ax.z = az.x;
		}
		var ay = az.cross(ax);
		if( rightHanded ) {
			mcam._11 = ax.x;
			mcam._12 = ay.x;
			mcam._13 = -az.x;
			mcam._14 = 0;
			mcam._21 = ax.y;
			mcam._22 = ay.y;
			mcam._23 = -az.y;
			mcam._24 = 0;
			mcam._31 = ax.z;
			mcam._32 = ay.z;
			mcam._33 = -az.z;
			mcam._34 = 0;
			mcam._41 = -ax.dot3(pos);
			mcam._42 = -ay.dot3(pos);
			mcam._43 = az.dot3(pos);
			mcam._44 = 1;
		} else {
			mcam._11 = ax.x;
			mcam._12 = ay.x;
			mcam._13 = az.x;
			mcam._14 = 0;
			mcam._21 = ax.y;
			mcam._22 = ay.y;
			mcam._23 = az.y;
			mcam._24 = 0;
			mcam._31 = ax.z;
			mcam._32 = ay.z;
			mcam._33 = az.z;
			mcam._34 = 0;
			mcam._41 = -ax.dot3(pos);
			mcam._42 = -ay.dot3(pos);
			mcam._43 = -az.dot3(pos);
			mcam._44 = 1;
		}
		mproj = makeFrustumMatrix();
		m.multiply(mcam, mproj);
		needInv = true;
	}
	
	public function lostUp() {
		var p2 = pos.clone();
		p2.normalize();
		return Math.abs(p2.dot3(up)) > 0.999;
	}
	
	public function movePosAxis( dx : Float, dy : Float, dz = 0. ) {
		var p = new Vector(dx, dy, dz);
		p.project(mcam);
		pos.x += p.x;
		pos.y += p.y;
		pos.z += p.z;
	}

	public function moveTargetAxis( dx : Float, dy : Float, dz = 0. ) {
		var p = new Vector(dx, dy, dz);
		p.project(mcam);
		target.x += p.x;
		target.y += p.y;
		target.z += p.z;
	}
	
	function makeFrustumMatrix() {
		var scale = zoom / Math.tan(fov * Math.PI / 360.0);
		var m = new Matrix();
		m.zero();
		
		// this will take into account the aspect ratio and normalize the z value into [0,1] once it's been divided by w
		// Matrixes have to solve the following formulaes :
		//
		// transform P by Mproj and divide everything by
		//    [x,y,-zNear,1] => [sx/zNear, sy/zNear, 0, 1]
		//    [x,y,-zFar,1] => [sx/zFar, sy/zFar, 1, 1]
		
		if( orthographic ) {
			var scale = zoom * 2 / pos.sub(target).length();
			if( rightHanded ) {
				m._11 = scale;
				m._22 = scale * ratio;
				m._33 = -1 / (zNear - zFar);
				m._43 = zNear / (zNear - zFar);
				m._44 = 1;
			} else {
				m._11 = scale;
				m._22 = -scale * ratio;
				m._33 = 1 / (zNear - zFar);
				m._43 = zNear / (zNear - zFar);
				m._44 = 1;
			}
		} else if( rightHanded ) {
			m._11 = scale;
			m._22 = scale * ratio;
			m._33 = zFar / (zFar - zNear);
			m._34 = 1;
			m._43 = -(zNear * zFar) / (zFar - zNear);
		} else {
			m._11 = scale;
			m._22 = -scale * ratio;
			m._33 = zFar / (zNear - zFar);
			m._34 = -1;
			m._43 = -(zNear * zFar) / (zFar - zNear);
		}

		m._11 += viewport.x * m._14;
		m._21 += viewport.x * m._24;
		m._31 += viewport.x * m._34;
		m._41 += viewport.x * m._44;

		m._12 += viewport.y * m._14;
		m._22 += viewport.y * m._24;
		m._32 += viewport.y * m._34;
		m._42 += viewport.y * m._44;
				
		return m;
	}
		
}
