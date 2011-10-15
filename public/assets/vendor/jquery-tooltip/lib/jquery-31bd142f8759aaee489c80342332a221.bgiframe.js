/* Copyright (c) 2006 Brandon Aaron (http://brandonaaron.net)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) 
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * $LastChangedDate: 2007-06-20 03:23:36 +0200 (Mi, 20 Jun 2007) $
 * $Rev: 2110 $
 *
 * Version 2.1
 */
(function(a){a.fn.bgIframe=a.fn.bgiframe=function(b){if(a.browser.msie&&parseInt(a.browser.version)<=6){b=a.extend({top:"auto",left:"auto",width:"auto",height:"auto",opacity:!0,src:"javascript:false;"},b||{});var c=function(a){return a&&a.constructor==Number?a+"px":a},d='<iframe class="bgiframe"frameborder="0"tabindex="-1"src="'+b.src+'"'+'style="display:block;position:absolute;z-index:-1;'+(b.opacity!==!1?"filter:Alpha(Opacity='0');":"")+"top:"+(b.top=="auto"?"expression(((parseInt(this.parentNode.currentStyle.borderTopWidth)||0)*-1)+'px')":c(b.top))+";"+"left:"+(b.left=="auto"?"expression(((parseInt(this.parentNode.currentStyle.borderLeftWidth)||0)*-1)+'px')":c(b.left))+";"+"width:"+(b.width=="auto"?"expression(this.parentNode.offsetWidth+'px')":c(b.width))+";"+"height:"+(b.height=="auto"?"expression(this.parentNode.offsetHeight+'px')":c(b.height))+";"+'"/>';return this.each(function(){a("> iframe.bgiframe",this).length==0&&this.insertBefore(document.createElement(d),this.firstChild)})}return this},a.browser.version||(a.browser.version=navigator.userAgent.toLowerCase().match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/)[1])})(jQuery)