pro imgen, lsize, fname

im = dist(fix(lsize))
window, xsize=lsize, ysize=lsize
tvscl, fix(im)
openw, imagefile, fname, /get_lun
for i=0,(lsize-1) do begin
  for j=0,(lsize-1) do begin
    printf,imagefile,format='(Z04)',fix(im[i,j])
  endfor
endfor
close, imagefile

end