/*
 * jQuery delegate plug-in v1.0
 *
 * Copyright (c) 2007 Jörn Zaefferer
 *
 * $Id: jquery.delegate.js 4786 2008-02-19 20:02:34Z joern.zaefferer $
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
// provides cross-browser focusin and focusout events
// IE has native support, in other browsers, use event caputuring (neither bubbles)
// provides delegate(type: String, delegate: Selector, handler: Callback) plugin for easier event delegation
// handler is only called when $(event.target).is(delegate), in the scope of the jQuery-object for event.target 
// provides triggerEvent(type: String, target: Element) to trigger delegated events
(function(a){a.each({focus:"focusin",blur:"focusout"},function(b,c){a.event.special[c]={setup:function(){if(a.browser.msie)return!1;this.addEventListener(b,a.event.special[c].handler,!0)},teardown:function(){if(a.browser.msie)return!1;this.removeEventListener(b,a.event.special[c].handler,!0)},handler:function(b){return arguments[0]=a.event.fix(b),arguments[0].type=c,a.event.handle.apply(this,arguments)}}}),a.extend(a.fn,{delegate:function(b,c,d){return this.bind(b,function(b){var e=a(b.target);if(e.is(c))return d.apply(e,arguments)})},triggerEvent:function(a,b){return this.triggerHandler(a,[jQuery.event.fix({type:a,target:b})])}})})(jQuery)