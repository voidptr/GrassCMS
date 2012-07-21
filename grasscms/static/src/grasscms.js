(function(){(function(e,c){var b,f,a,d;d="PersistentGrass";a=c.document;f={debug:false};b=(function(){function g(i,h){this.element=i;this.options=e.extend({},f,h);this.element=e(this.element);this._defaults=f;this._name=d;this.init()}g.prototype.init=function(){this.do_resizable();this.restore_from_server();this.element.on("mouseenter",function(h){return this.style.border="1px dotted grey"});this.element.on("mouseleave",function(h){return this.mouseleave(this)});this.properties=["width","height","opacity","top","left"];this.element.on("dragstart",this.dragstart);this.element.on("drag",this.drag);this.element.on("dragend",this.dragend);return this.element.on("changed",this.changed)};g.prototype.mouseleave=function(h){h.style.border="0px";if(h.css("height")!==e(h).data("height")){e(h).trigger("changed","height",h.style.height);e(h).data("height",e(h).css("height"))}if(h.css("width")!==e(h).data("width")){e(h).trigger("changed","width",h.style.width);return e(h).data("width",e(h).css("width"))}};g.prototype.do_resizable=function(){this.element=this.element.wrap('<div class="resizable">').parent();this.element.data("width",this.element.css("width"));return this.element.data("height",this.element.css("height"))};g.prototype.restore_from_server=function(){var l,k,i,j,h;j=this.properties;h=[];for(k=0,i=j.length;k<i;k++){l=j[k];h.push(this.element.css(l,this.get_property(l)))}return h};g.prototype.dragstart=function(h){e(this).data("opacity",this.style.opacity);this.style.border="1px dotted grey";return this.style.opacity=0.4};g.prototype.drag=function(h){e(this).attr("draggable","true");this.style.top=h.originalEvent.y+"px";this.style.left=h.originalEvent.x+"px";return this.style.position="absolute"};g.prototype.dragend=function(h){this.style.opacity=e(this).data("opacity")>0?e(this).data("opacity"):1;e(this).trigger("changed","top",h.y);return e(this).trigger("changed","left",h.x)};g.prototype.changed=function(i,h){var j;j=e(this).attr("id");return e.ajax("/object/",{type:"PUT",dataType:"json",data:JSON.stringify({id:j,attr:i,result:h})})};return g})();return e.fn[d]=function(g){return this.each(function(){if(!e.data(this,"plugin_"+d)){return e.data(this,"plugin_"+d,new b(this,g))}})}})(jQuery,window)}).call(this);(function(){(function(j,l){var g,i,h,k;k="PersistentGrass";h=l.document;i={debug:false};g=(function(){function a(b,c){this.element=b;this.options=j.extend({},i,c);this.element=j(this.element);this._defaults=i;this._name=k;this.init()}a.prototype.init=function(){this.do_resizable();this.restore_from_server();this.element.on("mouseenter",function(b){return this.style.border="1px dotted grey"});this.element.on("mouseleave",function(b){return this.mouseleave(this)});this.properties=["width","height","opacity","top","left"];this.element.on("dragstart",this.dragstart);this.element.on("drag",this.drag);this.element.on("dragend",this.dragend);return this.element.on("changed",this.changed)};a.prototype.mouseleave=function(b){b.style.border="0px";if(b.css("height")!==j(b).data("height")){j(b).trigger("changed","height",b.style.height);j(b).data("height",j(b).css("height"))}if(b.css("width")!==j(b).data("width")){j(b).trigger("changed","width",b.style.width);return j(b).data("width",j(b).css("width"))}};a.prototype.do_resizable=function(){this.element=this.element.wrap('<div class="resizable">').parent();this.element.data("width",this.element.css("width"));this.element.data("height",this.element.css("height"));return console.log(j(this))};a.prototype.restore_from_server=function(){var b,c,e,d,f;d=this.properties;f=[];for(c=0,e=d.length;c<e;c++){b=d[c];f.push(this.element.css(b,this.get_property(b)))}return f};a.prototype.dragstart=function(b){j(this).data("opacity",this.style.opacity);this.style.border="1px dotted grey";return this.style.opacity=0.4};a.prototype.drag=function(b){j(this).attr("draggable","true");this.style.top=b.originalEvent.y+"px";this.style.left=b.originalEvent.x+"px";return this.style.position="absolute"};a.prototype.dragend=function(b){this.style.opacity=j(this).data("opacity")>0?j(this).data("opacity"):1;j(this).trigger("changed","top",b.y);return j(this).trigger("changed","left",b.x)};a.prototype.changed=function(c,d){var b;b=j(this).attr("id");return j.ajax("/object/",{type:"PUT",dataType:"json",data:JSON.stringify({id:b,attr:c,result:d})})};return a})();return j.fn[k]=function(a){return this.each(function(){if(!j.data(this,"plugin_"+k)){return j.data(this,"plugin_"+k,new g(this,a))}})}})(jQuery,window)}).call(this);(function(){(function(c,a){var f,d,e,b;b="PersistentGrass";e=a.document;d={debug:false};f=(function(){function g(h,i){this.element=h;this.options=c.extend({},d,i);this.element=c(this.element);this._defaults=d;this._name=b;this.init()}g.prototype.init=function(){this.do_resizable();this.restore_from_server();this.element.on("mouseenter",function(h){return this.style.border="1px dotted grey"});this.element.on("mouseleave",function(h){return this.mouseleave(this)});this.properties=["width","height","opacity","top","left"];this.element.on("dragstart",this.dragstart);this.element.on("drag",this.drag);this.element.on("dragend",this.dragend);return this.element.on("changed",this.changed)};g.prototype.mouseleave=function(h){h.style.border="0px";if(h.css("height")!==c(h).data("height")){c(h).trigger("changed","height",h.style.height);c(h).data("height",c(h).css("height"))}if(h.css("width")!==c(h).data("width")){c(h).trigger("changed","width",h.style.width);return c(h).data("width",c(h).css("width"))}};g.prototype.do_resizable=function(){this.element=this.element.wrap('<div class="resizable">').parent();this.element.data("width",this.element.css("width"));this.element.data("height",this.element.css("height"));return console.log(c(this))};g.prototype.restore_from_server=function(){var h,l,j,k,i;k=this.properties;i=[];for(l=0,j=k.length;l<j;l++){h=k[l];i.push(this.element.css(h,this.get_property(h)))}return i};g.prototype.dragstart=function(h){c(this).data("opacity",this.style.opacity);this.style.border="1px dotted grey";return this.style.opacity=0.4};g.prototype.drag=function(h){c(this).attr("draggable","true");this.style.top=h.originalEvent.y+"px";this.style.left=h.originalEvent.x+"px";return this.style.position="absolute"};g.prototype.dragend=function(h){this.style.opacity=c(this).data("opacity")>0?c(this).data("opacity"):1;c(this).trigger("changed","top",h.y);return c(this).trigger("changed","left",h.x)};g.prototype.changed=function(j,i){var h;h=c(this).attr("id");return c.ajax("/object/",{type:"PUT",dataType:"json",data:JSON.stringify({id:h,attr:j,result:i})})};return g})();return c.fn[b]=function(g){return this.each(function(){if(!c.data(this,"plugin_"+b)){return c.data(this,"plugin_"+b,new f(this,g))}})}})(jQuery,window)}).call(this);(function(){(function(l,h){var i,k,j,g;g="PersistentGrass";j=h.document;k={debug:false};i=(function(){function a(c,b){this.element=c;this.options=l.extend({},k,b);this.element=l(this.element);this._defaults=k;this._name=g;this.init()}a.prototype.init=function(){this.do_resizable();this.restore_from_server();this.element.on("mouseenter",function(b){return this.style.border="1px dotted grey"});this.element.on("mouseleave",function(b){return this.mouseleave(this)});this.properties=["width","height","opacity","top","left"];this.element.on("dragstart",this.dragstart);this.element.on("drag",this.drag);this.element.on("dragend",this.dragend);return this.element.on("changed",this.changed)};a.prototype.mouseleave=function(b){b.style.border="0px";if(b.css("height")!==l(b).data("height")){l(b).trigger("changed","height",b.style.height);l(b).data("height",l(b).css("height"))}if(b.css("width")!==l(b).data("width")){l(b).trigger("changed","width",b.style.width);return l(b).data("width",l(b).css("width"))}};a.prototype.do_resizable=function(){this.element=this.element.wrap('<div class="resizable">').parent();this.element.data("width",this.element.css("width"));this.element.data("height",this.element.css("height"));return console.log(l(this))};a.prototype.restore_from_server=function(){var f,b,d,c,e;c=this.properties;e=[];for(b=0,d=c.length;b<d;b++){f=c[b];e.push(this.element.css(f,this.get_property(f)))}return e};a.prototype.dragstart=function(b){l(this).data("opacity",this.style.opacity);this.style.border="1px dotted grey";return this.style.opacity=0.4};a.prototype.drag=function(b){l(this).attr("draggable","true");this.style.top=b.originalEvent.y+"px";this.style.left=b.originalEvent.x+"px";return this.style.position="absolute"};a.prototype.dragend=function(b){this.style.opacity=l(this).data("opacity")>0?l(this).data("opacity"):1;l(this).trigger("changed","top",b.y);return l(this).trigger("changed","left",b.x)};a.prototype.changed=function(b,c){var d;d=l(this).attr("id");return l.ajax("/object/",{type:"PUT",dataType:"json",data:JSON.stringify({id:d,attr:b,result:c})})};return a})();return l.fn[g]=function(a){return this.each(function(){if(!l.data(this,"plugin_"+g)){return l.data(this,"plugin_"+g,new i(this,a))}})}})(jQuery,window)}).call(this);(function(){(function(a,e){var d,b,c,f;f="PersistentGrass";c=e.document;b={debug:false};d=(function(){function g(i,h){this.element=i;this.options=a.extend({},b,h);this.element=a(this.element);this._defaults=b;this._name=f;this.init()}g.prototype.init=function(){this.do_resizable();this.restore_from_server();this.element.on("mouseenter",function(h){return this.style.border="1px dotted grey"});this.element.on("mouseleave",function(h){return this.mouseleave(this)});this.properties=["width","height","opacity","top","left"];this.element.on("dragstart",this.dragstart);this.element.on("drag",this.drag);this.element.on("dragend",this.dragend);return this.element.on("changed",this.changed)};g.prototype.mouseleave=function(h){h.style.border="0px";if(h.css("height")!==a(h).data("height")){a(h).trigger("changed","height",h.style.height);a(h).data("height",a(h).css("height"))}if(h.css("width")!==a(h).data("width")){a(h).trigger("changed","width",h.style.width);return a(h).data("width",a(h).css("width"))}};g.prototype.do_resizable=function(){this.element=this.element.wrap('<div class="resizable">').parent();this.element.data("width",this.element.css("width"));this.element.data("height",this.element.css("height"));return console.log(a(this))};g.prototype.restore_from_server=function(){var i,h,k,l,j;l=this.properties;j=[];for(h=0,k=l.length;h<k;h++){i=l[h];j.push(this.element.css(i,this.get_property(i)))}return j};g.prototype.dragstart=function(h){a(this).data("opacity",this.style.opacity);this.style.border="1px dotted grey";return this.style.opacity=0.4};g.prototype.drag=function(h){a(this).attr("draggable","true");this.style.top=h.originalEvent.y+"px";this.style.left=h.originalEvent.x+"px";return this.style.position="absolute"};g.prototype.dragend=function(h){this.style.opacity=a(this).data("opacity")>0?a(this).data("opacity"):1;a(this).trigger("changed","top",h.y);return a(this).trigger("changed","left",h.x)};g.prototype.changed=function(h,j){var i;i=a(this).attr("id");return a.ajax("/object/",{type:"PUT",dataType:"json",data:JSON.stringify({id:i,attr:h,result:j})})};return g})();return a.fn[f]=function(g){return this.each(function(){if(!a.data(this,"plugin_"+f)){return a.data(this,"plugin_"+f,new d(this,g))}})}})(jQuery,window)}).call(this);(function(){(function(h,j){var k,g,l,i;i="PersistentGrass";l=j.document;g={debug:false};k=(function(){function a(b,c){this.element=b;this.options=h.extend({},g,c);this.element=h(this.element);this._defaults=g;this._name=i;this.init()}a.prototype.init=function(){this.do_resizable();this.restore_from_server();this.element.on("mouseenter",function(b){return this.style.border="1px dotted grey"});this.element.on("mouseleave",function(b){return this.mouseleave(this)});this.properties=["width","height","opacity","top","left"];this.element.on("dragstart",this.dragstart);this.element.on("drag",this.drag);this.element.on("dragend",this.dragend);return this.element.on("changed",this.changed)};a.prototype.mouseleave=function(b){b.style.border="0px";if(b.css("height")!==h(b).data("height")){h(b).trigger("changed","height",b.style.height);h(b).data("height",h(b).css("height"))}if(b.css("width")!==h(b).data("width")){h(b).trigger("changed","width",b.style.width);return h(b).data("width",h(b).css("width"))}};a.prototype.do_resizable=function(){this.element=this.element.wrap('<div class="resizable">').parent();this.element.data("width",this.element.css("width"));this.element.data("height",this.element.css("height"));return console.log(h(this))};a.prototype.restore_from_server=function(){var e,f,c,b,d;b=this.properties;d=[];for(f=0,c=b.length;f<c;f++){e=b[f];d.push(this.element.css(e,this.get_property(e)))}return d};a.prototype.dragstart=function(b){h(this).data("opacity",this.style.opacity);this.style.border="1px dotted grey";return this.style.opacity=0.4};a.prototype.drag=function(b){h(this).attr("draggable","true");this.style.top=b.originalEvent.y+"px";this.style.left=b.originalEvent.x+"px";return this.style.position="absolute"};a.prototype.dragend=function(b){this.style.opacity=h(this).data("opacity")>0?h(this).data("opacity"):1;h(this).trigger("changed","top",b.y);return h(this).trigger("changed","left",b.x)};a.prototype.changed=function(d,b){var c;c=h(this).attr("id");return h.ajax("/object/",{type:"PUT",dataType:"json",data:JSON.stringify({id:c,attr:d,result:b})})};return a})();return h.fn[i]=function(a){return this.each(function(){if(!h.data(this,"plugin_"+i)){return h.data(this,"plugin_"+i,new k(this,a))}})}})(jQuery,window)}).call(this);