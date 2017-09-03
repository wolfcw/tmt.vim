function! TMTFolds(lnum)
perl << .
	my $lnum = VIM::Eval('a:lnum');
	my @lines = $curbuf->Get(1 .. $lnum);
	my $foldlevel = 0;
	my $lineno = 0;
	my $groupfoldlevel = 0;
	my $startofnewlevel = 0;
	
	foreach my $line (@lines) {
		$lineno++;
		$startofnewlevel = 0;
		if ($line =~ m/^\s*(\[+)/) {
			my $groupcmd = $1;
			my $newdepth = $groupcmd =~ tr/\[//;
			$foldlevel = $newdepth;
			$groupfoldlevel = $foldlevel;
			$startofnewlevel = 1;
			# VIM::Msg("TMT: $line gives $groupcmd, depth $foldlevel");
		}
		elsif ($line =~ m/^\s*[-+*#]/) {
			# VIM::Msg("TMT: task found in line $lineno");
			$foldlevel = $groupfoldlevel + 1;
			$startofnewlevel = 1;
		}
		elsif ($line =~ m/^\s*[ABCDEFGHIJKLMNOPQRSTUVWXYZ@%]:/) {
			$foldlevel = $groupfoldlevel + 2;
		}
		elsif ($line =~ m/^\s*$/) {
			# keep previous foldlevel
			$foldlevel = -1;
		}
		else {
			$foldlevel = $groupfoldlevel + 3;
		}
	}
	
	my $returnvalue = $foldlevel;
	if ($startofnewlevel == 1) { $returnvalue = ">" . $returnvalue; }
	
	$ENV{'TMTFoldLevel'} = $returnvalue;
	# VIM::Msg("TMT Foldlevel of line " . $lnum . " is " . $foldlevel);
.
  return $TMTFoldLevel
endfunction

setlocal foldmethod=expr
setlocal foldexpr=TMTFolds(v:lnum)

function! TMTFoldText()
  return getline(v:foldstart)
endfunction

setlocal foldtext=TMTFoldText()

setlocal foldlevel=3
" setlocal fdc=7

highlight Folded guibg=black guifg=cyan
highlight FoldColumn guibg=black guifg=gray
