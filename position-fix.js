'use strict';
const F=window.FF;
F.position=()=>requestAnimationFrame(()=>{
  const workspace=document.getElementById('workspace');
  const artboard=document.getElementById('artboard');
  if(!workspace||!artboard)return;
  const x=workspace.clientWidth/2-F.s.doc.canvas.width*F.s.zoom/2+F.s.panX;
  const y=workspace.clientHeight/2-F.s.doc.canvas.height*F.s.zoom/2+F.s.panY;
  artboard.style.transform=`translate(${x}px,${y}px) scale(${F.s.zoom})`;
});
