pro anim_interp, xsize, ysize, fnames, interps

compile_opt idl2

close, /all

filecount = n_elements(fnames)
print, filecount, ' images read'
images = make_array(xsize, ysize, filecount, /float)
for fcount=0,(filecount-1) do begin
  fname = fnames[fcount]
  openr, imagefile, fname, /get_lun
  for i=0,(xsize-1) do begin
    for j=0,(ysize-1) do begin
      readf, imagefile, line, format=('(Z04)')
      if (float(line) le 32000) then images[i,j,fcount]=float(line) else images[i,j,fcount]=(-float(line))
    endfor
  endfor
  close, imagefile
endfor

for i=0,(filecount-1) do begin
  images[*,*,i]=((images[*,*,i]-min(images[*,*,i]))/(max(images[*,*,i])-min(images[*,*,i])))*(!d.table_size-1)
endfor

images = interpolate(images, lindgen(xsize), lindgen(ysize), ((findgen(interps)/float(interps))*float(filecount)), /grid)

xinteranimate, set=[xsize, ysize, interps], /showload
for i=0,(interps-1) do xinteranimate, frame = i, image=images[*,*,i]
xinteranimate, 10, /keep_pixmaps

end