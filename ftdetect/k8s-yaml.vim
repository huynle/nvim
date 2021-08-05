" file detection of kubernetes yamls
function! DetectYaml()
   if getline(1) =~ 'apiVersion:'
     setfiletype yaml
   endif
   if getline(1) =~ '---'
     setfiletype yaml
   endif
endfunction

augroup filetypedetect
  au StdinReadPost * call DetectYaml()
augroup END
