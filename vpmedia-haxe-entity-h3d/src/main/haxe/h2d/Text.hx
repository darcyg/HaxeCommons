package h2d;

class Text extends Drawable {

	public var font(default, set) : Font;
	public var text(default, set) : String;
	public var textColor(default, set) : Int;
	public var maxWidth(default, set) : Null<Float>;
	public var dropShadow : { dx : Float, dy : Float, color : Int, alpha : Float };
	
	public var textWidth(get, null) : Int;
	public var textHeight(get, null) : Int;
	
	var glyphs : TileGroup;
	
	public function new( font : Font, ?parent ) {
		super(parent);
		this.font = font;
		text = "";
		textColor = 0xFFFFFF;
	}
	
	function set_font(font) {
		this.font = font;
		if( glyphs != null ) glyphs.remove();
		glyphs = new TileGroup(font, this);
		shader = glyphs.shader;
		this.text = text;
		return font;
	}
	
	override function onAlloc() {
		super.onAlloc();
		if( text != null ) initGlyphs();
	}
	
	override function draw(ctx:RenderContext) {
		glyphs.blendMode = blendMode;
		if( dropShadow != null ) {
			glyphs.x += dropShadow.dx;
			glyphs.y += dropShadow.dy;
			glyphs.calcAbsPos();
			var old = glyphs.color;
			glyphs.color = h3d.Color.fromInt(dropShadow.color, dropShadow.alpha).toVector();
			glyphs.draw(ctx);
			glyphs.x -= dropShadow.dx;
			glyphs.y -= dropShadow.dy;
			glyphs.color = old;
		}
		super.draw(ctx);
	}
	
	function set_text(t) {
		this.text = t == null ? "null" : t;
		if( allocated ) initGlyphs();
		return t;
	}
	
	function initGlyphs( rebuild = true ) {
		if( rebuild ) glyphs.reset();
		var letters = font.glyphs;
		var x = 0, y = 0, xMax = 0;
		for( i in 0...text.length ) {
			var cc = text.charCodeAt(i);
			var e = letters[cc];
			// if the next word goes past the max width, change it into a newline
			if( cc == ' '.code && maxWidth != null ) {
				var size = x + e.width + 1;
				var k = i + 1, max = text.length;
				while( size <= maxWidth ) {
					var cc = text.charCodeAt(k++);
					if( cc == null || cc == ' '.code || cc == '\n'.code ) break;
					var e = letters[cc];
					if( e != null ) size += e.width + 1;
				}
				if( size > maxWidth ) {
					e = null;
					cc = '\n'.code;
				}
			}
			if( e == null ) {
				if( cc == '\n'.code ) {
					if( x > xMax ) xMax = x;
					x = 0;
					y += font.lineHeight;
				}
				continue;
			}
			if( rebuild ) glyphs.add(x, y, e);
			x += e.width + 1;
		}
		return { width : x > xMax ? x : xMax, height : x > 0 ? y + font.lineHeight : y };
	}
	
	function get_textHeight() {
		return initGlyphs(false).height;
	}
	
	function get_textWidth() {
		return initGlyphs(false).width;
	}
	
	function set_maxWidth(w) {
		maxWidth = w;
		this.text = text;
		return w;
	}
	
	function set_textColor(c) {
		this.textColor = c;
		glyphs.color = h3d.Color.fromInt(c, alpha).toVector();
		return c;
	}

}