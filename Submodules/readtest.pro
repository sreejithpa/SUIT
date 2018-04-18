pro readtest, xsize, ysize, fname

close, /all
openr, imagefile, fname, /get_lun
imagearray = make_array(xsize, ysize, /float)
for i=0,(xsize-1) do begin
  for j=0,(ysize-1) do begin
    readf, imagefile, line, format=('(Z04)')
    if (float(line) le 32000) then imagearray[i,j]=float(line) else imagearray[i,j]=(-float(line))
  endfor
endfor
window, xsize=xsize, ysize=ysize
plot_image, imagearray
close, imagefile

end