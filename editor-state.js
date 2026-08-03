'use strict';
const F=window.FF;
F.sel=()=>F.s.doc.layers.find(l=>l.id===F.s.selected)||null;
F.push=()=>{F.s.history.push(F.clone(F.s.doc));if(F.s.history.length>60)F.s.history.shift();F.s.future=[]};
F.undo=()=>{if(!F.s.history.length)return;F.s.future.push(F.clone(F.s.doc));F.s.doc=F.s.history.pop();F.s.selected=null;F.queueSave();F.render()};
F.redo=()=>{if(!F.s.future.length)return;F.s.history.push(F.clone(F.s.doc));F.s.doc=F.s.future.pop();F.s.selected=null;F.queueSave();F.render()};
F.tool=(t,n,l)=>`<button class="tool-btn ${F.s.tool===t?'active':''}" data-action="tool" data-tool="${t}">${F.icon(n)}<span>${l}</span></button>`;
F.layer=l=>{let v=l.type==='text'?`color:${l.fill};font-size:${l.fontSize||28}px;font-weight:${l.fontWeight||700};line-height:${l.lineHeight||1.15};`:l.type==='image'?`border-radius:${l.radius||0}px;overflow:hidden;`:`background:${l.fill};border-radius:${l.type==='ellipse'?'50%':`${l.radius||0}px`};`;let c=`layer layer-${l.type} ${F.s.selected===l.id?'selected':''} ${l.locked?'locked':''}`;let x=l.type==='image'?`<img src="${F.esc(l.src||'')}">`:l.type==='text'?F.esc(l.text||'Texto'):'';return`<div class="${c}" data-layer-id="${l.id}" style="left:${l.x}px;top:${l.y}px;width:${l.width}px;height:${l.height}px;opacity:${l.opacity??1};transform:rotate(${l.rotation||0}deg);z-index:${l.z||1};${v}">${x}${F.s.selected===l.id&&!l.locked?'<span class="resize-handle" data-action="resize-layer"></span>':''}</div>`};
