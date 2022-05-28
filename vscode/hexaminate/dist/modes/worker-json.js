!function(t){if(!(void 0!==t.window&&t.document||t.require&&t.define)){t.console||(t.console=function(){var t=Array.prototype.slice.call(arguments,0);postMessage({type:"log",data:t})},t.console.error=t.console.warn=t.console.log=t.console.trace=t.console),t.window=t,t.ace=t,t.onerror=function(t,i,n,r,s){postMessage({type:"error",data:{message:t,data:s.data,file:i,line:n,col:r,stack:s.stack}})},t.normalizeModule=function(i,n){if(-1!==n.indexOf("!")){var r=n.split("!");return t.normalizeModule(i,r[0])+"!"+t.normalizeModule(i,r[1])}if("."==n.charAt(0)){var s=i.split("/").slice(0,-1).join("/");for(n=(s?s+"/":"")+n;-1!==n.indexOf(".")&&e!=n;){var e=n;n=n.replace(/^\.\//,"").replace(/\/\.\//,"/").replace(/[^\/]+\/\.\.\//,"")}}return n},t.require=function(i,n){if(n||(n=i,i=null),!n.charAt)throw new Error("worker.js require() accepts only (parentId, id) as arguments");n=t.normalizeModule(i,n);var r=t.require.modules[n];if(r)return r.initialized||(r.initialized=!0,r.exports=r.factory().exports),r.exports;if(t.require.tlns){var s=function(t,i){for(var n=t,r="";n;){var s=i[n];if("string"==typeof s)return s+r;if(s)return s.location.replace(/\/*$/,"/")+(r||s.main||s.name);if(!1===s)return"";var e=n.lastIndexOf("/");if(-1===e)break;r=n.substr(e)+r,n=n.slice(0,e)}return t}(n,t.require.tlns);return".js"!=s.slice(-3)&&(s+=".js"),t.require.id=n,t.require.modules[n]={},importScripts(s),t.require(i,n)}},t.require.modules={},t.require.tlns={},t.define=function(i,n,r){if(2==arguments.length?(r=n,"string"!=typeof i&&(n=i,i=t.require.id)):1==arguments.length&&(r=i,n=[],i=t.require.id),"function"==typeof r){n.length||(n=["require","exports","module"]);var s=function(n){return t.require(i,n)};t.require.modules[i]={exports:{},factory:function(){var t=this,i=r.apply(this,n.slice(0,r.length).map((function(i){switch(i){case"require":return s;case"exports":return t.exports;case"module":return t;default:return s(i)}})));return i&&(t.exports=i),t}}}else t.require.modules[i]={exports:r,initialized:!0}},t.define.amd={},require.tlns={},t.initBaseUrls=function(t){for(var i in t)require.tlns[i]=t[i]},t.initSender=function(){var i=t.require("ace/lib/event_emitter").EventEmitter,n=t.require("ace/lib/oop"),r=function(){};return function(){n.implement(this,i),this.callback=function(t,i){postMessage({type:"call",id:i,data:t})},this.emit=function(t,i){postMessage({type:"event",name:t,data:i})}}.call(r.prototype),new r};var i=t.main=null,n=t.sender=null;t.onmessage=function(r){var s=r.data;if(s.event&&n)n._signal(s.event,s.data);else if(s.command)if(i[s.command])i[s.command].apply(i,s.args);else{if(!t[s.command])throw new Error("Unknown command:"+s.command);t[s.command].apply(t,s.args)}else if(s.init){t.initBaseUrls(s.tlns),n=t.sender=t.initSender();var e=require(s.module)[s.classname];i=t.main=new e(n)}}}}(this),ace.define("ace/lib/oop",[],(function(t,i,n){"use strict";i.inherits=function(t,i){t.super_=i,t.prototype=Object.create(i.prototype,{constructor:{value:t,enumerable:!1,writable:!0,configurable:!0}})},i.mixin=function(t,i){for(var n in i)t[n]=i[n];return t},i.implement=function(t,n){i.mixin(t,n)}})),ace.define("ace/range",[],(function(t,i,n){"use strict";var r=function(t,i,n,r){this.start={row:t,column:i},this.end={row:n,column:r}};(function(){this.isEqual=function(t){return this.start.row===t.start.row&&this.end.row===t.end.row&&this.start.column===t.start.column&&this.end.column===t.end.column},this.toString=function(){return"Range: ["+this.start.row+"/"+this.start.column+"] -> ["+this.end.row+"/"+this.end.column+"]"},this.contains=function(t,i){return 0==this.compare(t,i)},this.compareRange=function(t){var i,n=t.end,r=t.start;return 1==(i=this.compare(n.row,n.column))?1==(i=this.compare(r.row,r.column))?2:0==i?1:0:-1==i?-2:-1==(i=this.compare(r.row,r.column))?-1:1==i?42:0},this.comparePoint=function(t){return this.compare(t.row,t.column)},this.containsRange=function(t){return 0==this.comparePoint(t.start)&&0==this.comparePoint(t.end)},this.intersects=function(t){var i=this.compareRange(t);return-1==i||0==i||1==i},this.isEnd=function(t,i){return this.end.row==t&&this.end.column==i},this.isStart=function(t,i){return this.start.row==t&&this.start.column==i},this.setStart=function(t,i){"object"==typeof t?(this.start.column=t.column,this.start.row=t.row):(this.start.row=t,this.start.column=i)},this.setEnd=function(t,i){"object"==typeof t?(this.end.column=t.column,this.end.row=t.row):(this.end.row=t,this.end.column=i)},this.inside=function(t,i){return 0==this.compare(t,i)&&(!this.isEnd(t,i)&&!this.isStart(t,i))},this.insideStart=function(t,i){return 0==this.compare(t,i)&&!this.isEnd(t,i)},this.insideEnd=function(t,i){return 0==this.compare(t,i)&&!this.isStart(t,i)},this.compare=function(t,i){return this.isMultiLine()||t!==this.start.row?t<this.start.row?-1:t>this.end.row?1:this.start.row===t?i>=this.start.column?0:-1:this.end.row===t?i<=this.end.column?0:1:0:i<this.start.column?-1:i>this.end.column?1:0},this.compareStart=function(t,i){return this.start.row==t&&this.start.column==i?-1:this.compare(t,i)},this.compareEnd=function(t,i){return this.end.row==t&&this.end.column==i?1:this.compare(t,i)},this.compareInside=function(t,i){return this.end.row==t&&this.end.column==i?1:this.start.row==t&&this.start.column==i?-1:this.compare(t,i)},this.clipRows=function(t,i){if(this.end.row>i)var n={row:i+1,column:0};else if(this.end.row<t)n={row:t,column:0};if(this.start.row>i)var s={row:i+1,column:0};else if(this.start.row<t)s={row:t,column:0};return r.fromPoints(s||this.start,n||this.end)},this.extend=function(t,i){var n=this.compare(t,i);if(0==n)return this;if(-1==n)var s={row:t,column:i};else var e={row:t,column:i};return r.fromPoints(s||this.start,e||this.end)},this.isEmpty=function(){return this.start.row===this.end.row&&this.start.column===this.end.column},this.isMultiLine=function(){return this.start.row!==this.end.row},this.clone=function(){return r.fromPoints(this.start,this.end)},this.collapseRows=function(){return 0==this.end.column?new r(this.start.row,0,Math.max(this.start.row,this.end.row-1),0):new r(this.start.row,0,this.end.row,0)},this.toScreenRange=function(t){var i=t.documentToScreenPosition(this.start),n=t.documentToScreenPosition(this.end);return new r(i.row,i.column,n.row,n.column)},this.moveBy=function(t,i){this.start.row+=t,this.start.column+=i,this.end.row+=t,this.end.column+=i}}).call(r.prototype),r.fromPoints=function(t,i){return new r(t.row,t.column,i.row,i.column)},r.comparePoints=function(t,i){return t.row-i.row||t.column-i.column},r.comparePoints=function(t,i){return t.row-i.row||t.column-i.column},i.Range=r})),ace.define("ace/apply_delta",[],(function(t,i,n){"use strict";i.applyDelta=function(t,i,n){var r=i.start.row,s=i.start.column,e=t[r]||"";switch(i.action){case"insert":if(1===i.lines.length)t[r]=e.substring(0,s)+i.lines[0]+e.substring(s);else{var h=[r,1].concat(i.lines);t.splice.apply(t,h),t[r]=e.substring(0,s)+t[r],t[r+i.lines.length-1]+=e.substring(s)}break;case"remove":var u=i.end.column,o=i.end.row;r===o?t[r]=e.substring(0,s)+e.substring(u):t.splice(r,o-r+1,e.substring(0,s)+t[o].substring(u))}}})),ace.define("ace/lib/event_emitter",[],(function(t,i,n){"use strict";var r={},s=function(){this.propagationStopped=!0},e=function(){this.defaultPrevented=!0};r._emit=r._dispatchEvent=function(t,i){this._eventRegistry||(this._eventRegistry={}),this._defaultHandlers||(this._defaultHandlers={});var n=this._eventRegistry[t]||[],r=this._defaultHandlers[t];if(n.length||r){"object"==typeof i&&i||(i={}),i.type||(i.type=t),i.stopPropagation||(i.stopPropagation=s),i.preventDefault||(i.preventDefault=e),n=n.slice();for(var h=0;h<n.length&&(n[h](i,this),!i.propagationStopped);h++);return r&&!i.defaultPrevented?r(i,this):void 0}},r._signal=function(t,i){var n=(this._eventRegistry||{})[t];if(n){n=n.slice();for(var r=0;r<n.length;r++)n[r](i,this)}},r.once=function(t,i){var n=this;if(this.on(t,(function r(){n.off(t,r),i.apply(null,arguments)})),!i)return new Promise((function(t){i=t}))},r.setDefaultHandler=function(t,i){var n=this._defaultHandlers;if(n||(n=this._defaultHandlers={_disabled_:{}}),n[t]){var r=n[t],s=n._disabled_[t];s||(n._disabled_[t]=s=[]),s.push(r);var e=s.indexOf(i);-1!=e&&s.splice(e,1)}n[t]=i},r.removeDefaultHandler=function(t,i){var n=this._defaultHandlers;if(n){var r=n._disabled_[t];if(n[t]==i)r&&this.setDefaultHandler(t,r.pop());else if(r){var s=r.indexOf(i);-1!=s&&r.splice(s,1)}}},r.on=r.addEventListener=function(t,i,n){this._eventRegistry=this._eventRegistry||{};var r=this._eventRegistry[t];return r||(r=this._eventRegistry[t]=[]),-1==r.indexOf(i)&&r[n?"unshift":"push"](i),i},r.off=r.removeListener=r.removeEventListener=function(t,i){this._eventRegistry=this._eventRegistry||{};var n=this._eventRegistry[t];if(n){var r=n.indexOf(i);-1!==r&&n.splice(r,1)}},r.removeAllListeners=function(t){t||(this._eventRegistry=this._defaultHandlers=void 0),this._eventRegistry&&(this._eventRegistry[t]=void 0),this._defaultHandlers&&(this._defaultHandlers[t]=void 0)},i.EventEmitter=r})),ace.define("ace/anchor",[],(function(t,i,n){"use strict";var r=t("./lib/oop"),s=t("./lib/event_emitter").EventEmitter,e=i.Anchor=function(t,i,n){this.$onChange=this.onChange.bind(this),this.attach(t),void 0===n?this.setPosition(i.row,i.column):this.setPosition(i,n)};(function(){function t(t,i,n){var r=n?t.column<=i.column:t.column<i.column;return t.row<i.row||t.row==i.row&&r}function i(i,n,r){var s="insert"==i.action,e=(s?1:-1)*(i.end.row-i.start.row),h=(s?1:-1)*(i.end.column-i.start.column),u=i.start,o=s?u:i.end;return t(n,u,r)?{row:n.row,column:n.column}:t(o,n,!r)?{row:n.row+e,column:n.column+(n.row==o.row?h:0)}:{row:u.row,column:u.column}}r.implement(this,s),this.getPosition=function(){return this.$clipPositionToDocument(this.row,this.column)},this.getDocument=function(){return this.document},this.$insertRight=!1,this.onChange=function(t){if(!(t.start.row==t.end.row&&t.start.row!=this.row||t.start.row>this.row)){var n=i(t,{row:this.row,column:this.column},this.$insertRight);this.setPosition(n.row,n.column,!0)}},this.setPosition=function(t,i,n){var r;if(r=n?{row:t,column:i}:this.$clipPositionToDocument(t,i),this.row!=r.row||this.column!=r.column){var s={row:this.row,column:this.column};this.row=r.row,this.column=r.column,this._signal("change",{old:s,value:r})}},this.detach=function(){this.document.off("change",this.$onChange)},this.attach=function(t){this.document=t||this.document,this.document.on("change",this.$onChange)},this.$clipPositionToDocument=function(t,i){var n={};return t>=this.document.getLength()?(n.row=Math.max(0,this.document.getLength()-1),n.column=this.document.getLine(n.row).length):t<0?(n.row=0,n.column=0):(n.row=t,n.column=Math.min(this.document.getLine(n.row).length,Math.max(0,i))),i<0&&(n.column=0),n}}).call(e.prototype)})),ace.define("ace/document",[],(function(t,i,n){"use strict";var r=t("./lib/oop"),s=t("./apply_delta").applyDelta,e=t("./lib/event_emitter").EventEmitter,h=t("./range").Range,u=t("./anchor").Anchor,o=function(t){this.$lines=[""],0===t.length?this.$lines=[""]:Array.isArray(t)?this.insertMergedLines({row:0,column:0},t):this.insert({row:0,column:0},t)};(function(){r.implement(this,e),this.setValue=function(t){var i=this.getLength()-1;this.remove(new h(0,0,i,this.getLine(i).length)),this.insert({row:0,column:0},t)},this.getValue=function(){return this.getAllLines().join(this.getNewLineCharacter())},this.createAnchor=function(t,i){return new u(this,t,i)},0==="aaa".split(/a/).length?this.$split=function(t){return t.replace(/\r\n|\r/g,"\n").split("\n")}:this.$split=function(t){return t.split(/\r\n|\r|\n/)},this.$detectNewLine=function(t){var i=t.match(/^.*?(\r\n|\r|\n)/m);this.$autoNewLine=i?i[1]:"\n",this._signal("changeNewLineMode")},this.getNewLineCharacter=function(){switch(this.$newLineMode){case"windows":return"\r\n";case"unix":return"\n";default:return this.$autoNewLine||"\n"}},this.$autoNewLine="",this.$newLineMode="auto",this.setNewLineMode=function(t){this.$newLineMode!==t&&(this.$newLineMode=t,this._signal("changeNewLineMode"))},this.getNewLineMode=function(){return this.$newLineMode},this.isNewLine=function(t){return"\r\n"==t||"\r"==t||"\n"==t},this.getLine=function(t){return this.$lines[t]||""},this.getLines=function(t,i){return this.$lines.slice(t,i+1)},this.getAllLines=function(){return this.getLines(0,this.getLength())},this.getLength=function(){return this.$lines.length},this.getTextRange=function(t){return this.getLinesForRange(t).join(this.getNewLineCharacter())},this.getLinesForRange=function(t){var i;if(t.start.row===t.end.row)i=[this.getLine(t.start.row).substring(t.start.column,t.end.column)];else{(i=this.getLines(t.start.row,t.end.row))[0]=(i[0]||"").substring(t.start.column);var n=i.length-1;t.end.row-t.start.row==n&&(i[n]=i[n].substring(0,t.end.column))}return i},this.insertLines=function(t,i){return this.insertFullLines(t,i)},this.removeLines=function(t,i){return this.removeFullLines(t,i)},this.insertNewLine=function(t){return this.insertMergedLines(t,["",""])},this.insert=function(t,i){return this.getLength()<=1&&this.$detectNewLine(i),this.insertMergedLines(t,this.$split(i))},this.insertInLine=function(t,i){var n=this.clippedPos(t.row,t.column),r=this.pos(t.row,t.column+i.length);return this.applyDelta({start:n,end:r,action:"insert",lines:[i]},!0),this.clonePos(r)},this.clippedPos=function(t,i){var n=this.getLength();void 0===t?t=n:t<0?t=0:t>=n&&(t=n-1,i=void 0);var r=this.getLine(t);return null==i&&(i=r.length),{row:t,column:i=Math.min(Math.max(i,0),r.length)}},this.clonePos=function(t){return{row:t.row,column:t.column}},this.pos=function(t,i){return{row:t,column:i}},this.$clipPosition=function(t){var i=this.getLength();return t.row>=i?(t.row=Math.max(0,i-1),t.column=this.getLine(i-1).length):(t.row=Math.max(0,t.row),t.column=Math.min(Math.max(t.column,0),this.getLine(t.row).length)),t},this.insertFullLines=function(t,i){var n=0;(t=Math.min(Math.max(t,0),this.getLength()))<this.getLength()?(i=i.concat([""]),n=0):(i=[""].concat(i),t--,n=this.$lines[t].length),this.insertMergedLines({row:t,column:n},i)},this.insertMergedLines=function(t,i){var n=this.clippedPos(t.row,t.column),r={row:n.row+i.length-1,column:(1==i.length?n.column:0)+i[i.length-1].length};return this.applyDelta({start:n,end:r,action:"insert",lines:i}),this.clonePos(r)},this.remove=function(t){var i=this.clippedPos(t.start.row,t.start.column),n=this.clippedPos(t.end.row,t.end.column);return this.applyDelta({start:i,end:n,action:"remove",lines:this.getLinesForRange({start:i,end:n})}),this.clonePos(i)},this.removeInLine=function(t,i,n){var r=this.clippedPos(t,i),s=this.clippedPos(t,n);return this.applyDelta({start:r,end:s,action:"remove",lines:this.getLinesForRange({start:r,end:s})},!0),this.clonePos(r)},this.removeFullLines=function(t,i){t=Math.min(Math.max(0,t),this.getLength()-1);var n=(i=Math.min(Math.max(0,i),this.getLength()-1))==this.getLength()-1&&t>0,r=i<this.getLength()-1,s=n?t-1:t,e=n?this.getLine(s).length:0,u=r?i+1:i,o=r?0:this.getLine(u).length,c=new h(s,e,u,o),f=this.$lines.slice(t,i+1);return this.applyDelta({start:c.start,end:c.end,action:"remove",lines:this.getLinesForRange(c)}),f},this.removeNewLine=function(t){t<this.getLength()-1&&t>=0&&this.applyDelta({start:this.pos(t,this.getLine(t).length),end:this.pos(t+1,0),action:"remove",lines:["",""]})},this.replace=function(t,i){return t instanceof h||(t=h.fromPoints(t.start,t.end)),0===i.length&&t.isEmpty()?t.start:i==this.getTextRange(t)?t.end:(this.remove(t),i?this.insert(t.start,i):t.start)},this.applyDeltas=function(t){for(var i=0;i<t.length;i++)this.applyDelta(t[i])},this.revertDeltas=function(t){for(var i=t.length-1;i>=0;i--)this.revertDelta(t[i])},this.applyDelta=function(t,i){var n="insert"==t.action;(n?t.lines.length<=1&&!t.lines[0]:!h.comparePoints(t.start,t.end))||(n&&t.lines.length>2e4?this.$splitAndapplyLargeDelta(t,2e4):(s(this.$lines,t,i),this._signal("change",t)))},this.$safeApplyDelta=function(t){var i=this.$lines.length;("remove"==t.action&&t.start.row<i&&t.end.row<i||"insert"==t.action&&t.start.row<=i)&&this.applyDelta(t)},this.$splitAndapplyLargeDelta=function(t,i){for(var n=t.lines,r=n.length-i+1,s=t.start.row,e=t.start.column,h=0,u=0;h<r;h=u){u+=i-1;var o=n.slice(h,u);o.push(""),this.applyDelta({start:this.pos(s+h,e),end:this.pos(s+u,e=0),action:t.action,lines:o},!0)}t.lines=n.slice(h),t.start.row=s+h,t.start.column=e,this.applyDelta(t,!0)},this.revertDelta=function(t){this.$safeApplyDelta({start:this.clonePos(t.start),end:this.clonePos(t.end),action:"insert"==t.action?"remove":"insert",lines:t.lines.slice()})},this.indexToPosition=function(t,i){for(var n=this.$lines||this.getAllLines(),r=this.getNewLineCharacter().length,s=i||0,e=n.length;s<e;s++)if((t-=n[s].length+r)<0)return{row:s,column:t+n[s].length+r};return{row:e-1,column:t+n[e-1].length+r}},this.positionToIndex=function(t,i){for(var n=this.$lines||this.getAllLines(),r=this.getNewLineCharacter().length,s=0,e=Math.min(t.row,n.length),h=i||0;h<e;++h)s+=n[h].length+r;return s+t.column}}).call(o.prototype),i.Document=o})),ace.define("ace/lib/lang",[],(function(t,i,n){"use strict";i.last=function(t){return t[t.length-1]},i.stringReverse=function(t){return t.split("").reverse().join("")},i.stringRepeat=function(t,i){for(var n="";i>0;)1&i&&(n+=t),(i>>=1)&&(t+=t);return n};var r=/^\s\s*/,s=/\s\s*$/;i.stringTrimLeft=function(t){return t.replace(r,"")},i.stringTrimRight=function(t){return t.replace(s,"")},i.copyObject=function(t){var i={};for(var n in t)i[n]=t[n];return i},i.copyArray=function(t){for(var i=[],n=0,r=t.length;n<r;n++)t[n]&&"object"==typeof t[n]?i[n]=this.copyObject(t[n]):i[n]=t[n];return i},i.deepCopy=function t(i){if("object"!=typeof i||!i)return i;var n;if(Array.isArray(i)){n=[];for(var r=0;r<i.length;r++)n[r]=t(i[r]);return n}if("[object Object]"!==Object.prototype.toString.call(i))return i;for(var r in n={},i)n[r]=t(i[r]);return n},i.arrayToMap=function(t){for(var i={},n=0;n<t.length;n++)i[t[n]]=1;return i},i.createMap=function(t){var i=Object.create(null);for(var n in t)i[n]=t[n];return i},i.arrayRemove=function(t,i){for(var n=0;n<=t.length;n++)i===t[n]&&t.splice(n,1)},i.escapeRegExp=function(t){return t.replace(/([.*+?^${}()|[\]\/\\])/g,"\\$1")},i.escapeHTML=function(t){return(""+t).replace(/&/g,"&#38;").replace(/"/g,"&#34;").replace(/'/g,"&#39;").replace(/</g,"&#60;")},i.getMatchOffsets=function(t,i){var n=[];return t.replace(i,(function(t){n.push({offset:arguments[arguments.length-2],length:t.length})})),n},i.deferredCall=function(t){var i=null,n=function(){i=null,t()},r=function(t){return r.cancel(),i=setTimeout(n,t||0),r};return r.schedule=r,r.call=function(){return this.cancel(),t(),r},r.cancel=function(){return clearTimeout(i),i=null,r},r.isPending=function(){return i},r},i.delayedCall=function(t,i){var n=null,r=function(){n=null,t()},s=function(t){null==n&&(n=setTimeout(r,t||i))};return s.delay=function(t){n&&clearTimeout(n),n=setTimeout(r,t||i)},s.schedule=s,s.call=function(){this.cancel(),t()},s.cancel=function(){n&&clearTimeout(n),n=null},s.isPending=function(){return n},s}})),ace.define("ace/worker/mirror",[],(function(t,i,n){"use strict";t("../range").Range;var r=t("../document").Document,s=t("../lib/lang"),e=i.Mirror=function(t){this.sender=t;var i=this.doc=new r(""),n=this.deferredUpdate=s.delayedCall(this.onUpdate.bind(this)),e=this;t.on("change",(function(t){var r=t.data;if(r[0].start)i.applyDeltas(r);else for(var s=0;s<r.length;s+=2){if(Array.isArray(r[s+1]))var h={action:"insert",start:r[s],lines:r[s+1]};else h={action:"remove",start:r[s],end:r[s+1]};i.applyDelta(h,!0)}if(e.$timeout)return n.schedule(e.$timeout);e.onUpdate()}))};(function(){this.$timeout=500,this.setTimeout=function(t){this.$timeout=t},this.setValue=function(t){this.doc.setValue(t),this.deferredUpdate.schedule(this.$timeout)},this.getValue=function(t){this.sender.callback(this.doc.getValue(),t)},this.onUpdate=function(){},this.isPending=function(){return this.deferredUpdate.isPending()}}).call(e.prototype)})),ace.define("ace/mode/json/json_parse",[],(function(t,i,n){"use strict";var r,s,e,h,u={'"':'"',"\\":"\\","/":"/",b:"\b",f:"\f",n:"\n",r:"\r",t:"\t"},o=function(t){throw{name:"SyntaxError",message:t,at:r,text:e}},c=function(t){return t&&t!==s&&o("Expected '"+t+"' instead of '"+s+"'"),s=e.charAt(r),r+=1,s},f=function(){var t,i="";for("-"===s&&(i="-",c("-"));s>="0"&&s<="9";)i+=s,c();if("."===s)for(i+=".";c()&&s>="0"&&s<="9";)i+=s;if("e"===s||"E"===s)for(i+=s,c(),"-"!==s&&"+"!==s||(i+=s,c());s>="0"&&s<="9";)i+=s,c();if(t=+i,!isNaN(t))return t;o("Bad number")},a=function(){var t,i,n,r="";if('"'===s)for(;c();){if('"'===s)return c(),r;if("\\"===s)if(c(),"u"===s){for(n=0,i=0;i<4&&(t=parseInt(c(),16),isFinite(t));i+=1)n=16*n+t;r+=String.fromCharCode(n)}else{if("string"!=typeof u[s])break;r+=u[s]}else{if("\n"==s||"\r"==s)break;r+=s}}o("Bad string")},v=function(){for(;s&&s<=" ";)c()};return h=function(){switch(v(),s){case"{":return function(){var t,i={};if("{"===s){if(c("{"),v(),"}"===s)return c("}"),i;for(;s;){if(t=a(),v(),c(":"),Object.hasOwnProperty.call(i,t)&&o('Duplicate key "'+t+'"'),i[t]=h(),v(),"}"===s)return c("}"),i;c(","),v()}}o("Bad object")}();case"[":return function(){var t=[];if("["===s){if(c("["),v(),"]"===s)return c("]"),t;for(;s;){if(t.push(h()),v(),"]"===s)return c("]"),t;c(","),v()}}o("Bad array")}();case'"':return a();case"-":return f();default:return s>="0"&&s<="9"?f():function(){switch(s){case"t":return c("t"),c("r"),c("u"),c("e"),!0;case"f":return c("f"),c("a"),c("l"),c("s"),c("e"),!1;case"n":return c("n"),c("u"),c("l"),c("l"),null}o("Unexpected '"+s+"'")}()}},function(t,i){var n;return e=t,r=0,s=" ",n=h(),v(),s&&o("Syntax error"),"function"==typeof i?function t(n,r){var s,e,h=n[r];if(h&&"object"==typeof h)for(s in h)Object.hasOwnProperty.call(h,s)&&(void 0!==(e=t(h,s))?h[s]=e:delete h[s]);return i.call(n,r,h)}({"":n},""):n}})),ace.define("ace/mode/json_worker",[],(function(t,i,n){"use strict";var r=t("../lib/oop"),s=t("../worker/mirror").Mirror,e=t("./json/json_parse"),h=i.JsonWorker=function(t){s.call(this,t),this.setTimeout(200)};r.inherits(h,s),function(){this.onUpdate=function(){var t=this.doc.getValue(),i=[];try{t&&e(t)}catch(t){var n=this.doc.indexToPosition(t.at-1);i.push({row:n.row,column:n.column,text:t.message,type:"error"})}this.sender.emit("annotate",i)}}.call(h.prototype)}));