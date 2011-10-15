// jQuery Right-Click Plugin
//
// Version 1.01
//
// Cory S.N. LaViska
// A Beautiful Site (http://abeautifulsite.net/)
// 20 December 2008
//
// Visit http://abeautifulsite.net/notebook/68 for more information
//
// Usage:
//
//		// Capture right click
//		$("#selector").rightClick( function(e) {
//			// Do something
//		});
//		
//		// Capture right mouse down
//		$("#selector").rightMouseDown( function(e) {
//			// Do something
//		});
//		
//		// Capture right mouseup
//		$("#selector").rightMouseUp( function(e) {
//			// Do something
//		});
//		
//		// Disable context menu on an element
//		$("#selector").noContext();
// 
// History:
//
//		1.01 - Updated (20 December 2008)
//		     - References to 'this' now work the same way as other jQuery plugins, thus
//		       the el parameter has been deprecated.  Use this or $(this) instead
//		     - The mouse event is now passed to the callback function
//		     - Changed license to GNU GPL
//
//		1.00 - Released (13 May 2008)
//
// License:
// 
// This plugin is dual-licensed under the GNU General Public License and the MIT License
// and is copyright 2008 A Beautiful Site, LLC. 
//
jQuery&&function(){$.extend($.fn,{rightClick:function(a){return $(this).each(function(){$(this).mousedown(function(b){var c=b;$(this).mouseup(function(){return $(this).unbind("mouseup"),c.button==2?(a.call($(this),c),!1):!0})}),$(this)[0].oncontextmenu=function(){return!1}}),$(this)},rightMouseDown:function(a){return $(this).each(function(){$(this).mousedown(function(b){return b.button==2?(a.call($(this),b),!1):!0}),$(this)[0].oncontextmenu=function(){return!1}}),$(this)},rightMouseUp:function(a){return $(this).each(function(){$(this).mouseup(function(b){return b.button==2?(a.call($(this),b),!1):!0}),$(this)[0].oncontextmenu=function(){return!1}}),$(this)},noContext:function(){return $(this).each(function(){$(this)[0].oncontextmenu=function(){return!1}}),$(this)}})}(jQuery)