$print_type = 'pdf';
$pdf_mode = 1;
$new_viewer_always = 0;
$pdf_previewer = 'open -a Skim';
$pdf_update_method = 0;
$latex = 'latex --src-specials %O %S';
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode --shell-escape %O %S';

$success_cmd = "mvim --servername VIM --remote-expr \"latex#latexmk#errors(0)\"";
$failure_cmd = "mvim --servername VIM --remote-expr \"latex#latexmk#errors(0)\"";

# $compiling_cmd = "";
# $success_cmd = "";
# $failure_cmd = "";


# $pdf_update_method = 2;
# $pdf_update_signal = 'SIGHUP';
# $bibtex_use = 2;
# push @generated_exts, "cb";
# push @generated_exts, "cb2";
# push @generated_exts, "spl";
# push @generated_exts, "nav";
# push @generated_exts, "snm";
# push @generated_exts, "tdo";
# push @generated_exts, "nmo";
# push @generated_exts, "brf";
# push @generated_exts, "nlg";
# push @generated_exts, "nlo";
# push @generated_exts, "nls";
# push @generated_exts, "synctex.gz";
# push @generated_exts, "tex.latexmain";
# push @generated_exts, "run.xml";
# $latex = 'latex --src-specials %O %S';
# $pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode --shell-escape %O %S';
# $compiling_cmd
#              = "xdotool search --name %D set_window --name \"%D compiling...\"";
# $success_cmd = "xdotool search --name %D set_window --name \"%D OK\";";
# $failure_cmd = "xdotool search --name %D set_window --name \"%D FAILURE\";";
# 
# add_cus_dep('nlo', 'nls', 0, 'nlo2nls');
# sub nlo2nls {
#   system("makeindex $_[0].nlo -s nomencl.ist -o $_[0].nls -t $_[0].nlg" );
# }
# 
# vim: ft=perl

