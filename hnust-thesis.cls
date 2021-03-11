\NeedsTeXFormat{LaTeX2e}[2017/04/15]
\ProvidesClass{hnustthesis}
[2021/3/10 8.0.0 HNUST Thesis Template]
\newcommand\hnust@error[1]{%
  \ClassError{hnustthesis}{#1}{}%
}
\newcommand\hnust@warning[1]{%
  \ClassWarning{hnustthesis}{#1}%
}
\newcommand\hnust@patch@error[1]{%
  \hnust@error{Failed to patch command \protect#1}%
}
\newcommand\hnust@deprecate[2]{%
  \def\hnust@@tmp{#2}%
  \hnust@warning{%
    The #1 is deprecated%
    \ifx\hnust@@tmp\@empty\else
      . Use #2 instead%
    \fi
  }%
}
\@ifl@t@r\fmtversion{2017/04/15}{}{
  \hnust@error{%
    TeX Live 2017 or later version is required to compile this document%
  }
}
\RequirePackage{iftex}
\ifXeTeX\else
  \hnust@error{XeLaTeX is required to compile this document}
\fi
\InputIfFileExists{hnustthesis-pdf-test-config.tex}{}{
  \InputIfFileExists{hnustthesis-log-test-config.tex}{}{}
}
\hyphenation{hnust-Thesis}
\def\hnustthesis{hnustthesis}
\def\version{7.1.0}
\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=hnust,
  prefix=hnust@,
  setkeys=\kvsetkeys}
\newcommand\hnustsetup[1]{%
  \kvsetkeys{hnust}{#1}%
}
\newcommand\hnust@define@key[1]{%
  \kvsetkeys{hnust@key}{#1}%
}
\kv@set@family@handler{hnust@key}{%
  \@namedef{hnust@#1@@name}{#1}%
  \def\hnust@@default{}%
  \def\hnust@@choices{}%
  \kv@define@key{hnust@value}{name}{%
    \@namedef{hnust@#1@@name}{##1}%
  }%
  \@namedef{hnust@#1@@check}{}%
  \@namedef{hnust@#1@@code}{}%
  \kv@define@key{hnust@value}{choices}{%
    \def\hnust@@choices{##1}%
    \@namedef{hnust@#1@@reset}{}%
    \@namedef{hnust@#1@@check}{%
      \@ifundefined{%
        ifhnust@\@nameuse{hnust@#1@@name}@\@nameuse{hnust@\@nameuse{hnust@#1@@name}}%
      }{%
        \hnust@error{Invalid value "#1 = \@nameuse{hnust@\@nameuse{hnust@#1@@name}}"}%
      }%
      \@nameuse{hnust@#1@@reset}%
      \@nameuse{hnust@\@nameuse{hnust@#1@@name}@\@nameuse{hnust@\@nameuse{hnust@#1@@name}}true}%
    }%
  }%
  \kv@define@key{hnust@value}{default}{%
    \def\hnust@@default{##1}%
  }%
  \kvsetkeys{hnust@value}{#2}%
  \@namedef{hnust@\@nameuse{hnust@#1@@name}}{}%
  \kv@set@family@handler{hnust@choice}{%
    \ifx\hnust@@default\@empty
      \def\hnust@@default{##1}%
    \fi
    \expandafter\newif\csname ifhnust@\@nameuse{hnust@#1@@name}@##1\endcsname
    \expandafter\g@addto@macro\csname hnust@#1@@reset\endcsname{%
      \@nameuse{hnust@\@nameuse{hnust@#1@@name}@##1false}%
    }%
  }%
  \kvsetkeys@expandafter{hnust@choice}{\hnust@@choices}%
  \expandafter\let\csname hnust@\@nameuse{hnust@#1@@name}\endcsname\hnust@@default
  \expandafter\ifx\csname hnust@\@nameuse{hnust@#1@@name}\endcsname\@empty\else
    \@nameuse{hnust@#1@@check}%
  \fi
  \kv@define@key{hnust}{#1}{%
    \@namedef{hnust@\@nameuse{hnust@#1@@name}}{##1}%
    \@nameuse{hnust@#1@@check}%
    \@nameuse{hnust@#1@@code}%
  }%
}
\newcommand\hnust@option@hook[2]{%
  \expandafter\g@addto@macro\csname hnust@#1@@code\endcsname{#2}%
}
\hnust@define@key{
  degree = {
    choices = {
      bachelor,
      master,
      doctor,
      postdoc,
    },
    default = doctor,
  },
  degree-type = {
    choices = {
      academic,
      professional,
    },
    name = degree@type,
  },
  main-language = {
    name = main@language,
    choices = {
      chinese,
      english,
    },
  },
  language = {
    choices = {
      chinese,
      english,
    },
  },
  fontset = {
    choices = {
      windows,
      mac,
      ubuntu,
      fandol,
      none,
    },
    default = windows,
  },
  system = {
    choices = {
      mac,
      unix,
      windows,
      auto,
    },
    default = windows,
  },
  font = {
    choices = {
      times,
      termes,
      xits,
      libertinus,
      lm,
      auto,
      none,
    },
    default = times,
  },
  cjk-font = {
    name = cjk@font,
    choices = {
      windows,
      mac,
      noto,
      fandol,
      auto,
      none,
    },
    default = auto,
  },
  math-font = {
    name = math@font,
    choices = {
      xits,
      stix,
      libertinus,
      lm,
      none,
    },
    default = xits,
  },
  output = {
    choices = {
      print,
      electronic,
    },
    default = electronic,
  },
}
\newif\ifhnust@degree@graduate
\newcommand\hnust@set@graduate{%
  \hnust@degree@graduatefalse
  \ifhnust@degree@doctor
    \hnust@degree@graduatetrue
  \fi
  \ifhnust@degree@master
    \hnust@degree@graduatetrue
  \fi
}
\hnust@set@graduate
\hnust@option@hook{degree}{%
  \hnust@set@graduate
}
\DeclareBoolOption[false]{openright}
\DeclareComplementaryOption{openany}{openright}
\DeclareBoolOption[true]{raggedbottom}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*
\ifhnust@openright
  \PassOptionsToClass{openright}{book}
\else
  \PassOptionsToClass{openany}{book}
\fi
\PassOptionsToPackage{quiet}{fontspec}
\LoadClass[a4paper,UTF8,zihao=-4,scheme=plain,fontset=none]{ctexbook}[2017/04/01]
\RequirePackage{etoolbox}
\RequirePackage{filehook}
\RequirePackage{xparse}
\RequirePackage{geometry}%
\RequirePackage{fancyhdr}
\RequirePackage{titletoc}
\RequirePackage{notoccite}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage{graphicx}
\RequirePackage[labelformat=simple]{subcaption}
\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{environ}
\ifhnust@raggedbottom
  \RequirePackage[bottom,perpage,hang]{footmisc}
  \raggedbottom
\else
  \RequirePackage[perpage,hang]{footmisc}
\fi
\RequirePackage{xeCJKfntef}
\RequirePackage{soul}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{url}
\AtEndPreamble{
  \@ifpackageloaded{biblatex}{}{
    \@ifpackageloaded{apacite}{}{
      \RequirePackage{natbib}
    }
  }
}
\AtEndOfPackageFile*{natbib}{
  \@ifpackageloaded{apacite}{}{
    \RequirePackage{bibunits}
  }
}
\newcommand\hnust@package@conflict[2]{
  \AtBeginOfPackageFile*{#2}{
    \hnust@error{The "#2" package is incompatible with required "#1"}
  }
}
\hnust@package@conflict{unicode-math}{amscd}
\hnust@package@conflict{unicode-math}{amsfonts}
\hnust@package@conflict{unicode-math}{amssymb}
\hnust@package@conflict{unicode-math}{bbm}
\hnust@package@conflict{unicode-math}{bm}
\hnust@package@conflict{unicode-math}{eucal}
\hnust@package@conflict{unicode-math}{eufrak}
\hnust@package@conflict{unicode-math}{mathrsfs}
\geometry{
  paper          = a4paper,  % 210 * 297mm
  marginparwidth = 0pt,      % 去掉旁注宽度
  marginparsep   = 0pt,      % 去掉旁注和正文之间的距离，这样将整个旁注空间去掉
}
\setlength{\voffset}{0mm}      % 页眉高度 2cm
\setlength{\topmargin}{0mm}    %
\setlength{\headheight}{4mm}   %
\setlength{\headsep}{6mm}      %
\setlength{\textheight}{242mm} % 
\setlength{\textwidth}{160mm}  % 
\setlength{\footskip}{10mm}    % 页脚高度 1.5cm
\usepackage{showframe}         % 如果需要查看边框，可取消此注释
\newcommand\hnust@set@geometry{%
  \ifhnust@degree@bachelor
    \geometry{
      top        = 3.0cm,
      bottom     = 2.5cm,
      left       = 2.5cm,
      right      = 2.5cm,
      % headheight = 0.5cm,
      % headsep    = 1.0cm,
      % footskip   = 1.45cm,
    }%
    % \ifhnust@output@print
    %   \geometry{
    %     left       = 3.2cm,
    %     right      = 3cm,
    %   }%
    % \else
    %   \geometry{
    %     hmargin    = 3cm,
    %   }%
    % \fi
  \else
    \geometry{
      margin     = 3cm,
      headheight = 0.5cm,
      headsep    = 0.3cm,
      footskip   = 0.8cm,
    }%
  \fi
}
\hnust@set@geometry
\hnust@option@hook{degree}{\hnust@set@geometry}
\hnust@option@hook{output}{\hnust@set@geometry}
\def\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifhnust@output@print
      \ifodd\c@page
      \else
        \thispagestyle{empty}%
        \hbox{}%
        \newpage
        \if@twocolumn
          \hbox{}\newpage
        \fi
      \fi
    \fi
  \fi
}
\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}%
}
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}%
  \fancypagestyle{plain}{
    \fancyhead[C]{\songti\wuhao 湖南科技大学本科毕业设计(论文)} 
  }%
}
\renewcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
  \hnustsetup{toc-depth = 0}%
}
\ifhnust@fontset@mac
  \hnustsetup{
    font     = times,
    cjk-font = mac,
  }
\else
  \ifhnust@fontset@windows
    \hnustsetup{
      font     = times,
      cjk-font = windows,
    }
  \else
    \ifhnust@fontset@fandol
      \hnustsetup{
        font     = termes,
        cjk-font = fandol,
      }
    \else
      \ifhnust@fontset@ubuntu
        \hnustsetup{
          font     = termes,
          cjk-font = noto,
        }
      \fi
    \fi
  \fi
\fi
\ifhnust@system@auto
  \IfFileExists{/System/Library/Fonts/Menlo.ttc}{
    \hnustsetup{system = mac}
  }{
    \IfFileExists{/dev/null}{
      \IfFileExists{null:}{
        \hnustsetup{system = windows}
      }{
        \hnustsetup{system = unix}
      }
    }{
      \hnustsetup{system = windows}
    }
  }
\fi
\let\hnust@font@family@xits\@empty
\newcommand\hnust@set@xits@names{%
  \ifx\hnust@font@family@xits\@empty
    \IfFontExistsTF{XITSMath-Regular.otf}{%
      \gdef\hnust@font@family@xits{XITS}%
      \gdef\hnust@font@style@xits@rm{Regular}%
      \gdef\hnust@font@style@xits@bf{Bold}%
      \gdef\hnust@font@style@xits@it{Italic}%
      \gdef\hnust@font@style@xits@bfit{BoldItalic}%
      \gdef\hnust@font@name@xits@math@rm{XITSMath-Regular}%
      \gdef\hnust@font@name@xits@math@bf{XITSMath-Bold}%
    }{%
      \gdef\hnust@font@family@xits{xits}%
      \gdef\hnust@font@style@xits@rm{regular}%
      \gdef\hnust@font@style@xits@bf{bold}%
      \gdef\hnust@font@style@xits@it{italic}%
      \gdef\hnust@font@style@xits@bfit{bolditalic}%
      \gdef\hnust@font@name@xits@math@rm{xits-math}%
      \gdef\hnust@font@name@xits@math@bf{xits-mathbold}%
    }%
  \fi
}
\let\hnust@font@family@libertinus\@empty
\newcommand\hnust@set@libertinus@names{%
  \ifx\hnust@font@family@libertinus\@empty
    \IfFontExistsTF{LibertinusSerif-Regular.otf}{%
      \gdef\hnust@font@family@libertinus@serif{LibertinusSerif}%
      \gdef\hnust@font@family@libertinus@sans{LibertinusSans}%
      \gdef\hnust@font@name@libertinus@math{LibertinusMath-Regular}%
      \gdef\hnust@font@style@libertinus@rm{Regular}%
      \gdef\hnust@font@style@libertinus@bf{Bold}%
      \gdef\hnust@font@style@libertinus@it{Italic}%
      \gdef\hnust@font@style@libertinus@bfit{BoldItalic}%
    }{%
      \gdef\hnust@font@family@libertinus@serif{libertinusserif}%
      \gdef\hnust@font@family@libertinus@sans{libertinussans}%
      \gdef\hnust@font@name@libertinus@math{libertinusmath-regular}%
      \gdef\hnust@font@style@libertinus@rm{regular}%
      \gdef\hnust@font@style@libertinus@bf{bold}%
      \gdef\hnust@font@style@libertinus@it{italic}%
      \gdef\hnust@font@style@libertinus@bfit{bolditalic}%
    }%
  \fi
}
\ifhnust@font@auto
  \ifhnust@system@unix
    \hnustsetup{font=termes}
  \else
    \hnustsetup{font=times}
  \fi
\fi
\newcommand\hnust@load@font@times{%
  \setmainfont{Times New Roman}%
  \setsansfont{Times New Roman}%
  \ifhnust@system@mac
    \setmonofont{Menlo}[Scale = MatchLowercase]%
  \else
    \setmonofont{Courier New}[Scale = MatchLowercase]%
  \fi
}
\newcommand\hnust@load@font@termes{%
  \setmainfont{texgyretermes}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \hnust@load@texgyre@sans@mono
}
\newcommand\hnust@load@texgyre@sans@mono{%
  \setsansfont{texgyreheros}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setmonofont{texgyrecursor}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
    Ligatures      = CommonOff,
  ]%
}
\newcommand\hnust@load@font@xits{%
  \hnust@set@xits@names
  \setmainfont{\hnust@font@family@xits}[
    Extension      = .otf,
    UprightFont    = *-\hnust@font@style@xits@rm,
    BoldFont       = *-\hnust@font@style@xits@bf,
    ItalicFont     = *-\hnust@font@style@xits@it,
    BoldItalicFont = *-\hnust@font@style@xits@bfit,
  ]%
  \hnust@load@texgyre@sans@mono
}
\newcommand\hnust@load@font@libertinus{%
  \hnust@set@libertinus@names
  \setmainfont{\hnust@font@family@libertinus@serif}[
    Extension      = .otf,
    UprightFont    = *-\hnust@font@style@libertinus@rm,
    BoldFont       = *-\hnust@font@style@libertinus@bf,
    ItalicFont     = *-\hnust@font@style@libertinus@it,
    BoldItalicFont = *-\hnust@font@style@libertinus@bfit,
  ]%
  \setsansfont{\hnust@font@family@libertinus@sans}[
    Extension      = .otf,
    UprightFont    = *-\hnust@font@style@libertinus@rm,
    BoldFont       = *-\hnust@font@style@libertinus@bf,
    ItalicFont     = *-\hnust@font@style@libertinus@it,
  ]%
  \setmonofont{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}
\@namedef{hnust@load@font@lm}{%
  \setmainfont{lmroman10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setsansfont{lmsans10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
  \setmonofont{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}
\newcommand\hnust@load@font{%
  \@nameuse{hnust@load@font@\hnust@font}%
}
\hnust@load@font
\hnust@option@hook{font}{\hnust@load@font}
\unimathsetup{
  math-style = ISO,
  bold-style = ISO,
  nabla      = upright,
  partial    = upright,
}
\newcommand\hnust@load@math@font@xits{%
  \hnust@set@xits@names
  \setmathfont{\hnust@font@name@xits@math@rm}[
    Extension    = .otf,
    BoldFont     = \hnust@font@name@xits@math@bf,
    StylisticSet = 8,
  ]%
  \setmathfont{\hnust@font@name@xits@math@rm}[
    Extension    = .otf,
    StylisticSet = 1,
    range        = {cal,bfcal},
  ]%
}
\newcommand\hnust@load@math@font@stix{%
  \setmathfont{STIX2Math}[
    Extension    = .otf,
    StylisticSet = 8,
  ]%
  \setmathfont{STIX2Math}[
    Extension    = .otf,
    StylisticSet = 1,
    range        = {cal,bfcal},
  ]%
}
\newcommand\hnust@load@math@font@libertinus{%
  \hnust@set@libertinus@names
  \setmathfont{\hnust@font@name@libertinus@math .otf}%
}
\newcommand\hnust@load@math@font@lm{%
  \setmathfont{latinmodern-math.otf}%
}
\newcommand\hnust@load@math@font{%
  \@nameuse{hnust@load@math@font@\hnust@math@font}
}
\hnust@load@math@font
\hnust@option@hook{math-font}{\hnust@load@math@font}
\ifhnust@cjk@font@auto
  \ifhnust@system@mac
    \hnustsetup{cjk-font = mac}
  \else
    \ifhnust@system@windows
      \hnustsetup{cjk-font = windows}
    \else
      \IfFontExistsTF{Noto Serif CJK SC}{
        \hnustsetup{cjk-font = noto}
      }{
        \hnustsetup{cjk-font = fandol}
      }
    \fi
  \fi
\fi
\newcommand\hnust@load@cjk@font@windows{%
  \xeCJKsetup{EmboldenFactor=2}%
  \setCJKmainfont{SimSun}[
    AutoFakeBold = true,
    ItalicFont   = KaiTi,
  ]%
  \setCJKsansfont{SimSun}[AutoFakeBold]%
  \setCJKmonofont{FangSong}%
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold]%
  \setCJKfamilyfont{zhhei}{SimHei}%
  \setCJKfamilyfont{zhkai}{KaiTi}%
  \setCJKfamilyfont{zhfs}{FangSong}%
}
\newcommand\hnust@load@cjk@font@mac{%
  \setCJKmainfont{Songti SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = Kaiti SC,
    BoldItalicFont = Kaiti SC Bold,
  ]%
  \setCJKsansfont{Heiti SC}[BoldFont=* Medium]%
  \setCJKmonofont{STFangsong}
  \setCJKfamilyfont{zhsong}{Songti SC}[
    UprightFont = * Light,
      BoldFont  = * Bold,
  ]%
  \setCJKfamilyfont{zhhei}{Heiti SC}[
    UprightFont = * Light,
    BoldFont    = * Medium,
  ]%
  \setCJKfamilyfont{zhfs}{STFangsong}%
  \setCJKfamilyfont{zhkai}{Kaiti SC}[BoldFont = * Bold]%
  \setCJKfamilyfont{zhli}{Baoli SC}%
  \setCJKfamilyfont{zhyuan}{Yuanyi SC}[
    UprightFont = * Light,
    BoldFont    = * Bold,
  ]%
}
\newcommand\hnust@load@cjk@font@noto{%
  \setCJKmainfont{Noto Serif CJK SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = FandolKai-Regular,
    ItalicFeatures = {Extension = .otf},
  ]%
  \setCJKsansfont{Noto Sans CJK SC}[
    BoldFont    = * Medium,
  ]%
  \setCJKmonofont{Noto Sans Mono CJK SC}%
  \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}[
    UprightFont = * Light,
    UprightFont = * Bold,
  ]%
  \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}[
    BoldFont    = * Medium,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
}
\newcommand\hnust@load@cjk@font@fandol{%
  \setCJKmainfont{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
    ItalicFont  = FandolKai-Regular,
  ]%
  \setCJKsansfont{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKmonofont{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhsong}{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhhei}{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
}
\ifhnust@cjk@font@none\else
  \providecommand\songti{\CJKfamily{zhsong}}
  \providecommand\heiti{\CJKfamily{zhhei}}
  \providecommand\fangsong{\CJKfamily{zhfs}}
  \providecommand\kaishu{\CJKfamily{zhkai}}
\fi
\newcommand\hnust@load@cjk@font{%
  \@nameuse{hnust@load@cjk@font@\hnust@cjk@font}%
}
\hnust@load@cjk@font
\hnust@option@hook{cjk-font}{\hnust@load@cjk@font}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{19.455bp}% 小四，1.25倍行距
  \abovedisplayskip 0bp%
  \abovedisplayshortskip 0bp%
  \belowdisplayshortskip 0bp%
  \belowdisplayskip \abovedisplayskip
}
\normalsize
\ifx\MakeRobust\@undefined \else
    \MakeRobust\normalsize
\fi
\DeclareRobustCommand\small{%
   \@setfontsize\small{10.5bp}{17.5bp}%
   \abovedisplayskip 0bp%
   \abovedisplayshortskip 6bp%
   \belowdisplayshortskip 6bp%
   \def\@listi{\leftmargin\leftmargini
               \topsep \z@skip
               \parsep \z@skip
               \itemsep \z@skip}%
   \belowdisplayskip \abovedisplayskip
}
\DeclareRobustCommand\footnotesize{%
   \@setfontsize\footnotesize{9bp}{15bp}%
   \abovedisplayskip 0bp%
   \abovedisplayshortskip 6bp%
   \belowdisplayshortskip 6bp%
   \def\@listi{\leftmargin\leftmargini
               \topsep \z@skip
               \parsep \z@skip
               \itemsep \z@skip}%
   \belowdisplayskip \abovedisplayskip
}
\DeclareRobustCommand\scriptsize{\@setfontsize\scriptsize{7.5bp}{12.5bp}}
\DeclareRobustCommand\tiny{\@setfontsize\tiny{6.5bp}{10.83bp}}
\DeclareRobustCommand\large{\@setfontsize\large{15bp}{25bp}}
\DeclareRobustCommand\Large{\@setfontsize\Large{18bp}{30bp}}
\DeclareRobustCommand\LARGE{\@setfontsize\LARGE{22bp}{36.67bp}}
\DeclareRobustCommand\huge{\@setfontsize\huge{24bp}{40bp}}
\DeclareRobustCommand\Huge{\@setfontsize\Huge{26bp}{43.33bp}}
\def\hnust@def@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
    \fontsize{#2}{##1\dimexpr #2}\selectfont}}
\hnust@def@fontsize{chuhao}{42bp}
\hnust@def@fontsize{xiaochu}{36bp}
\hnust@def@fontsize{yihao}{26bp}
\hnust@def@fontsize{xiaoyi}{24bp}
\hnust@def@fontsize{erhao}{22bp}
\hnust@def@fontsize{xiaoer}{18bp}
\hnust@def@fontsize{sanhao}{16bp}
\hnust@def@fontsize{xiaosan}{15bp}
\hnust@def@fontsize{sihao}{14bp}
\hnust@def@fontsize{ssihao}{13bp}
\hnust@def@fontsize{xiaosi}{12bp}
\hnust@def@fontsize{wuhao}{10.5bp}
\hnust@def@fontsize{xiaowu}{9bp}
\hnust@def@fontsize{liuhao}{7.5bp}
\hnust@def@fontsize{xiaoliu}{6.5bp}
\hnust@def@fontsize{qihao}{5.5bp}
\hnust@def@fontsize{bahao}{5bp}
\hnustsetup{main-language=\hnust@language}%
\let\hnust@main@language\hnust@language
\hnust@option@hook{language}{%
  \ifx\@begindocumenthook\@undefined\else
    \hnustsetup{main-language=\hnust@language}%
    \let\hnust@main@language\hnust@language
  \fi
}
\newcommand\hnust@reset@main@language{%
    \hnustsetup{language = \hnust@main@language}%
    \let\hnust@language\hnust@main@language
}
\newcommand\hnust@set@chapter@names{%
  \ifhnust@main@language@chinese
    \ctexset{
      chapter/name   = {第,章},
    }%
    \def\bibname{参\,\,\,考\,\,\,文\,\,\,献}%
    \def\appendixname{附录}%
    \def\indexname{索引}%
    \def\hnust@acknowledgements@name{致\qquad 谢}%
    \ifhnust@degree@bachelor
      \def\contentsname{目\qquad 录}%
      \def\listfigurename{插图索引}%
      \def\listtablename{表格索引}%
      \def\hnust@list@figure@table@name{插图和附表索引}%
      \def\hnust@list@algorithm@name{算法索引}%
      \def\listequationname{公式索引}%
      \def\hnust@denotation@name{主要符号对照表}%
      \def\hnust@resume@name{在学期间参加课题的研究成果}%
    \else
      \def\listfigurename{插图清单}%
      \def\listtablename{附表清单}%
      \def\hnust@list@figure@table@name{插图和附表清单}%
      \def\hnust@list@algorithm@name{算法清单}%
      \def\listequationname{公式清单}%
      \ifhnust@degree@graduate
        \def\contentsname{目\qquad 录}%
        \def\hnust@denotation@name{符号和缩略语说明}%
        \def\hnust@resume@name{个人简历、在学期间完成的相关学术成果}%
      \else  % degree = postdoc
        \def\contentsname{目\qquad 次}%
        \def\hnust@denotation@name{符号表}%
        \def\hnust@resume@name{个人简历、发表的学术论文与科研成果}%
      \fi
    \fi
  \else
    \ifhnust@main@language@english
      \ctexset{
        chapter/name   = \chaptername\space,
      }%
      \def\indexname{Index}%
      \ifhnust@degree@bachelor
        \def\contentsname{CONTENTS}%
        \def\listfigurename{FIGURES}%
        \def\listtablename{TABLES}%
        \def\hnust@list@figure@table@name{FIGURES AND TABLES}%
        \def\hnust@list@algorithm@name{ALGORITHMS}%
        \def\listequationname{EQUATIONS}%
        \def\hnust@denotation@name{ABBREVIATIONS}%
        \def\bibname{REFERENCES}%
        \def\appendixname{APPENDIX}%
        \def\hnust@acknowledgements@name{ACKNOWLEDGEMENTS}%
        \def\hnust@resume@name{PUBLICATIONS}%
      \else
        \def\contentsname{Contents}%
        \def\listfigurename{List of Figures}%
        \def\listtablename{List of Tables}%
        \def\hnust@list@figure@table@name{List of Figures and Tables}%
        \def\hnust@list@algorithm@name{List of Algorithms}%
        \def\listequationname{List of Equations}%
        \def\hnust@denotation@name{Nomenclature}%
        \def\bibname{Bibliography}%
        \def\appendixname{Appendix}%
        \def\hnust@acknowledgements@name{Acknowledgements}%
        \def\hnust@resume@name{Resume and Academic Achievements}%
      \fi
    \fi
  \fi
}
\hnust@set@chapter@names
\hnust@option@hook{degree}{\hnust@set@chapter@names}
\hnust@option@hook{main-language}{\hnust@set@chapter@names}
\newcommand\hnust@set@names{%
  \ifhnust@language@chinese
    \ctexset{
      figurename = 图,
      tablename  = 表,
    }%
    \def\hnust@algorithm@name{算法}%
    \def\hnust@equation@name{公式}%
    \def\hnust@assumption@name{假设}%
    \def\hnust@definition@name{定义}%
    \def\hnust@proposition@name{命题}%
    \def\hnust@lemma@name{引理}%
    \def\hnust@theorem@name{定理}%
    \def\hnust@axiom@name{公理}%
    \def\hnust@corollary@name{推论}%
    \def\hnust@exercise@name{练习}%
    \def\hnust@example@name{例}%
    \def\hnust@remark@name{注释}%
    \def\hnust@problem@name{问题}%
    \def\hnust@conjecture@name{猜想}%
    \def\hnust@proof@name{证明}%
    \def\hnust@theorem@separator{：}%
  \else
    \ifhnust@language@english
      \ctexset{
        figurename = {Figure},
        tablename  = {Table},
      }%
      \def\hnust@algorithm@name{Algorithm}%
      \def\hnust@equation@name{Equation}%
      \def\hnust@assumption@name{Assumption}%
      \def\hnust@definition@name{Definition}%
      \def\hnust@proposition@name{Proposition}%
      \def\hnust@lemma@name{Lemma}%
      \def\hnust@theorem@name{Theorem}%
      \def\hnust@axiom@name{Axiom}%
      \def\hnust@corollary@name{Corollary}%
      \def\hnust@exercise@name{Exercise}%
      \def\hnust@example@name{Example}%
      \def\hnust@remark@name{Remark}%
      \def\hnust@problem@name{Problem}%
      \def\hnust@conjecture@name{Conjecture}%
      \def\hnust@proof@name{Proof}%
      \def\hnust@theorem@separator{: }%
    \fi
  \fi
}
\hnust@set@names
\hnust@option@hook{language}{\hnust@set@names}
\xeCJKDeclareCharClass{CJK}{"2460 -> "2473}
\xeCJKDeclareCharClass{CJK}{"2605}
\newcommand\hnust@set@punctuations{%
  \ifhnust@language@chinese
    \xeCJKDeclareCharClass{FullLeft}{"2018, "201C}%
    \xeCJKDeclareCharClass{FullRight}{
      "00B7, "2019, "201D, "2013, "2014, "2025, "2026, "2E3A,
    }%
  \else
    \ifhnust@language@english
      \xeCJKDeclareCharClass{HalfLeft}{"2018, "201C}%
      \xeCJKDeclareCharClass{HalfRight}{
        "00B7, "2019, "201D, "2013, "2014, "2025, "2026, "2E3A,
      }%
    \fi
  \fi
}
\hnust@set@punctuations
\hnust@option@hook{language}{\hnust@set@punctuations}
\pagestyle{fancy}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand\footrulewidth{0pt}%
  \ifhnust@degree@bachelor
    \renewcommand\headrulewidth{0pt}%
    \fancyfoot[C]{
      \ifhnust@main@language@chinese
        \xiaowu
      \else
        \normalsize
      \fi
      -\thepage-
    }%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
  \else
    \renewcommand\headrulewidth{0.75bp}%
    \fancyhead[C]{\wuhao\leftmark}%
    \fancyfoot[C]{\wuhao\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth{\CTEXifname{\CTEXthechapter\quad}{}##1}{}%
    }%
  \fi
  \let\sectionmark\@gobble
}
\pagestyle{plain}
\ctexset{chapter/pagestyle = plain}
\ctexset{%
  punct=quanjiao,
  space=auto,
}
\newcommand\hnust@set@indent{%
  \ifhnust@main@language@english
    \ifhnust@degree@bachelor
      \ctexset{autoindent=0.8cm}%
    \else
      \ctexset{autoindent=2}%
    \fi
  \else
    \ctexset{autoindent=2}%
  \fi
}
\hnust@set@indent
\hnust@option@hook{degree}{\hnust@set@indent}
\hnust@option@hook{main-language}{\hnust@set@indent}
\urlstyle{same}
\g@addto@macro\UrlBreaks{%
  \do0\do1\do2\do3\do4\do5\do6\do7\do8\do9%
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M
  \do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l\do\m
  \do\n\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z
}
\Urlmuskip=0mu plus 0.1mu
\partopsep=\z@skip
\def\@listi{\leftmargin\leftmargini
            \parsep \z@skip
            \topsep \z@skip
            \itemsep\z@skip}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    \z@skip
              \parsep    \z@skip
              \itemsep   \z@skip}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    \z@skip
              \parsep    \z@skip
              \partopsep \z@skip
              \itemsep   \z@skip}
\setlist{nosep}
\newcommand\hnust@circled[1]{%
  \ifnum#1 >10\relax
    \hnust@error{%
      Too many footnotes in this page.
      Keep footnote less than 10%
    }%
  \fi
  {\symbol{\the\numexpr#1+"245F\relax}}%
}
\renewcommand{\thefootnote}{\hnust@circled{\c@footnote}}
\renewcommand{\thempfootnote}{\hnust@circled{\c@mpfootnote}}
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\footnotemargin=13.5bp
\long\def\@makefntext#1{%
  \begingroup
    % 序号取消上标
    \def\@makefnmark{\hbox{\normalfont\@thefnmark}}%
    \xiaowu
    \ifFN@hangfoot
      \bgroup
      \setbox\@tempboxa\hbox{%
        \ifdim\footnotemargin>\z@
          \hb@xt@\footnotemargin{\@makefnmark\hss}%
        \else
          \@makefnmark
        \fi
      }%
      \leftmargin\wd\@tempboxa
      \rightmargin\z@
      \linewidth \columnwidth
      \advance \linewidth -\leftmargin
      \parshape \@ne \leftmargin \linewidth
      % \footnotesize
      \xiaowu
      \@setpar{{\@@par}}%
      \leavevmode
      \llap{\box\@tempboxa}%
      \parskip\hangfootparskip\relax
      \parindent\hangfootparindent\relax
    \else
      \parindent1em%
      \noindent
      \ifdim\footnotemargin>\z@
        \hb@xt@ \footnotemargin{\hss\@makefnmark}%
      \else
        \ifdim\footnotemargin=\z@
          \llap{\@makefnmark}%
        \else
          \llap{\hb@xt@ -\footnotemargin{\@makefnmark\hss}}%
        \fi
      \fi
    \fi
    \footnotelayout#1%
    \ifFN@hangfoot
      \par\egroup
    \fi
  \endgroup
}
\newcommand\hnust@set@math@ellipsis{%
  \ifhnust@language@chinese
    \DeclareRobustCommand\mathellipsis{\mathinner{\unicodecdots}}%
  \else
    \ifhnust@language@english
      \DeclareRobustCommand\mathellipsis{\mathinner{\unicodeellipsis}}%
    \fi
  \fi
}
\hnust@set@math@ellipsis
\hnust@option@hook{language}{\hnust@set@math@ellipsis}
\protected\def\le{\leqslant}
\protected\def\ge{\geqslant}
\AtBeginDocument{%
  \renewcommand\leq{\leqslant}%
  \renewcommand\geq{\geqslant}%
}
\removenolimits{%
  \int\iint\iiint\iiiint\oint\oiint\oiiint
  \intclockwise\varointclockwise\ointctrclockwise\sumint
  \intbar\intBar\fint\cirfnint\awint\rppolint
  \scpolint\npolint\pointint\sqint\intlarhk\intx
  \intcap\intcup\upint\lowint
}
\AtBeginDocument{%
  \renewcommand{\Re}{\operatorname{Re}}%
  \renewcommand{\Im}{\operatorname{Im}}%
}
\AtBeginDocument{%
  \renewcommand\nabla{\mbfnabla}%
}
\DeclareRobustCommand\bm[1]{{\symbf{#1}}}
\DeclareRobustCommand\boldsymbol[1]{{\symbf{#1}}}
\newcommand\square{\mdlgwhtsquare}
\AtBeginDocument{%
  \renewcommand\checkmark{\ensuremath{✓}}%
}
\allowdisplaybreaks[4]
\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@equation}
\def\fps@figure{h}
\def\fps@table{h}
\setlength{\floatsep}{6bp}
\setlength{\textfloatsep}{6bp}
\setlength{\intextsep}{6bp}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}
\patchcmd\@floatboxreset{%
  \normalsize
}{%
  \fontsize{11bp}{14.3bp}\selectfont
  \renewcommand\arraystretch{1.4}%
}{}{\hnust@patch@error{\@floatboxreset}}
\ifhnust@degree@bachelor
  \AtBeginDocument{% delay the check until all packages are loaded
    \g@addto@macro\appendix{\renewcommand*{\thefigure}{\thechapter-\arabic{figure}}}
    \g@addto@macro\appendix{\renewcommand*{\thetable}{\thechapter-\arabic{table}}}
  }
\fi
\newcommand\hnust@caption@font{}
\newcommand\hnust@set@caption@font{%
  \ifhnust@degree@bachelor
    \renewcommand\hnust@caption@font{\fontsize{11bp}{15bp}\selectfont}%
  \else
    \renewcommand\hnust@caption@font{\fontsize{11bp}{14.3bp}\selectfont}%
  \fi
}
\hnust@set@caption@font
\hnust@option@hook{degree}{\hnust@set@caption@font}
\DeclareCaptionFont{hnust}{\hnust@caption@font}
\captionsetup{
  format         = hang,
  font           = hnust,
  labelsep       = quad,
  aboveskip      = 6bp,
  belowskip      = 6bp,
  figureposition = bottom,
  tableposition  = top,
}
\captionsetup[sub]{font=hnust}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
\heavyrulewidth=1.5bp
\lightrulewidth=1bp
\AtEndOfPackageFile*{threeparttable}{
  \g@addto@macro\TPT@defaults{\wuhao}
}
\ifhnust@degree@bachelor
  \newcommand{\hnust@abstract@name}{摘\qquad 要}
  \newcommand{\hnust@abstract@name@en}{ABSTRACT}
\else
  \newcommand{\hnust@abstract@name}{摘\qquad 要}
  \newcommand{\hnust@abstract@name@en}{Abstract}
\fi
\ctexset{%
  chapter = {
    nameformat   = {},
    numberformat = {},
    titleformat  = {},
    aftername    = \quad,
    fixskip      = true,
    afterindent  = true,
    lofskip      = 0pt,
    lotskip      = 0pt,
  },
  section = {
    aftername    = \quad,
    afterindent  = true,
  },
  subsection = {
    aftername    = \quad,
    afterindent  = true,
  },
  subsubsection = {
    aftername    = \quad,
    afterindent  = true,
  },
  paragraph/afterindent = true,
  subparagraph/afterindent = true,
}
\newcommand\hnust@set@section@format{%
  \ifhnust@degree@bachelor
    \ctexset{%
      chapter = {
        format     = \centering\songti\xiaoer\bfseries\selectfont,
        beforeskip = 11.744pt,
        afterskip  = 11.744pt,
      },
      section = {
        format     = \songti\sihao\bfseries\selectfont,
        beforeskip = 15.5bp,
        afterskip  = 12.5bp,
      },
      subsection = {
        format     = \songti\xiaosi\bfseries\selectfont,
        beforeskip = 7.83pt,
        afterskip  = 7.83pt,
      },
      subsubsection = {
        format     = \songti\xiaosi\bfseries\selectfont,
        beforeskip = 7.83pt,
        afterskip  = 7.83pt,
      },
    }%
    \ifhnust@main@language@chinese
      \ctexset{chapter/number = \chinese{chapter}}%
    \else
      \ctexset{chapter/number = \hnust@english@number{chapter}}%
    \fi
  \else
    \ctexset{%
      chapter = {
        format     = \centering\sffamily\sanhao,
        beforeskip = 27bp,
        afterskip  = 27bp,
      },
      section = {
        format     = \sffamily\fontsize{14bp}{20bp}\selectfont,
        beforeskip = 24bp,
        afterskip  = 6bp,
      },
      subsection = {
        format     = \sffamily\fontsize{13bp}{20bp}\selectfont,
        beforeskip = 12bp,
        afterskip  = 6bp,
      },
      subsubsection = {
        format     = \sffamily\fontsize{12bp}{20bp}\selectfont,
        beforeskip = 12bp,
        afterskip  = 6bp,
      },
    }%
  \fi
}
\hnust@set@section@format
\hnust@option@hook{degree}{\hnust@set@section@format}
\newcommand\hnust@english@number[1]{%
  \expandafter\ifcase\csname c@#1\endcsname
    Zero\or
    One\or
    Two\or
    Three\or
    Four\or
    Five\or
    Six\or
    Seven\or
    Eight\or
    Nine\or
    Ten\or
    Eleven\or
    Twelve\or
    Thirteen\or
    Fourteen\or
    Fifteen\or
    Sixteen\or
    Seventeen\or
    Eighteen\or
    Nineteen\or
    Twenty\or
    \hnust@error{You are genius}%
  \fi
}
\newcommand\hnust@pdfbookmark[2]{}
\newcommand\hnust@phantomsection{}
\NewDocumentCommand\hnust@chapter{s o m o}{%
  \IfBooleanF{#1}{%
    \hnust@error{You have to use the star form: \string\hnust@chapter*}%
  }%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \IfValueTF{#2}{%
    \ifthenelse{\equal{#2}{}}{%
      \hnust@pdfbookmark{0}{#3}%
    }{%
      \hnust@phantomsection
      \addcontentsline{toc}{chapter}{#2}%
    }%
  }{%
    \hnust@phantomsection
    \addcontentsline{toc}{chapter}{#3}%
  }%
  \ifhnust@degree@bachelor\ctexset{chapter/afterskip=33bp}\fi
  \chapter*{#3}%
  \ifhnust@degree@bachelor\ctexset{chapter/afterskip=19bp}\fi
  \IfValueTF{#4}{%
    \ifthenelse{\equal{#4}{}}{%
      \@mkboth{}{}%
    }{%
      \@mkboth{#4}{#4}%
    }%
  }{%
    \@mkboth{#3}{#3}%
  }%
}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
\renewcommand\tableofcontents{%
  \fancypagestyle{plain}{
    \fancyhead[C]{\songti\wuhao 湖南科技大学本科毕业设计(论文)} 
  }%
  \ifhnust@degree@graduate
    \hnust@chapter*{\heiti\sanhao\contentsname}%
  \else
    \hnust@chapter*[]{\heiti\sanhao\contentsname}%
  \fi
  \@starttoc{toc}%
}
\hnust@define@key{
  toc-chapter-style = {
    name = toc@chapter@style,
    choices = {
      arial,
      times,
    },
    default = times,
  },
}
\newcommand\hnust@leaders{\titlerule*[4bp]{$\cdot$}}
\newcommand\hnust@set@toc@format{%
  \contentsmargin{\z@}%
  % \ifhnust@degree@bachelor
    % \ifhnust@main@language@chinese
      \titlecontents{chapter}
        [\z@]{
          % \addvspace{6bp}
          % \ifhnust@toc@chapter@style@arial
            % \sffamily\bfseries\sihao
          % \else
            \songti\bfseries\sihao
          % \fi
        }
        {\contentspush{\thecontentslabel\quad}}{}
        {\sihao\rmfamily\hnust@leaders\thecontentspage}%
      \titlecontents{section}
        [2em]{\songti\xiaosi}
        {\contentspush{\thecontentslabel\quad}}{}
        {\xiaosi\hnust@leaders\thecontentspage}%
      \titlecontents{subsection}
        [4em]{\songti\xiaosi}
        {\contentspush{\thecontentslabel\quad}}{}
        {\xiaosi\hnust@leaders\thecontentspage}%
    % \else
    %   \ifhnust@main@language@english
    %     \titlecontents{chapter}
    %       [\z@]{\addvspace{6bp}\sffamily}
    %       {\contentspush{\thecontentslabel\quad}}{}
    %       {\rmfamily\hnust@leaders\thecontentspage}%
    %     \titlecontents{section}
    %       [0.5cm]{}
    %       {\contentspush{\thecontentslabel\quad}}{}
    %       {\hnust@leaders\thecontentspage}%
    %     \titlecontents{subsection}
    %       [1cm]{}
    %       {\contentspush{\thecontentslabel\quad}}{}
    %       {\hnust@leaders\thecontentspage}%
    %   \fi
    % \fi
  % \else
  %   \titlecontents{chapter}
  %     [\z@]{\addvspace{6bp}\sffamily}
  %     {\contentspush{\thecontentslabel\quad}}{}
  %     {\rmfamily\hnust@leaders\thecontentspage}%
  %   \titlecontents{section}
  %     [1em]{}
  %     {\contentspush{\thecontentslabel\quad}}{}
  %     {\hnust@leaders\thecontentspage}%
  %   \titlecontents{subsection}
  %     [2em]{}
  %     {\contentspush{\thecontentslabel\quad}}{}
  %     {\hnust@leaders\thecontentspage}%
  % \fi
}
\hnust@set@toc@format
\hnust@option@hook{degree}{\hnust@set@toc@format}
\hnust@define@key{
  secret-level = {
    name = secret@level,
  },
  secret-year = {
    name = secret@year,
  },
  title = {
    default = {标题},
  },
  title* = {
    default = {Title},
    name    = title@en,
  },
  author = {
    default = {姓名},
  },
  author* = {
    default = {Name of author},
    name    = author@en,
  },
  supervisor = {
    default = {导师姓名},
  },
  supervisor* = {
    default = {Name of supervisor},
    name    = supervisor@en,
  },
  associate-supervisor = {
    name = associate@supervisor,
  },
  associate-supervisor* = {
    name = associate@supervisor@en,
  },
  joint-supervisor = {
    name = joint@supervisor,
  },
  joint-supervisor* = {
    name = joint@supervisor@en,
  },
  degree-name = {
    default = {工学博士},
    name    = degree@name,
  },
  degree-name* = {
    default = {Doctor of Philosophy},
    name    = degree@name@en,
  },
  department = {
    default = {计算机科学与技术系},
  },
  discipline = {
    % default = {计算机科学与技术},
  },
  discipline* = {
    % default = {Computer Science and Technology},
    name    = discipline@en,
  },
  date = {
    default = {\the\year-\two@digits{\month}-\two@digits{\day}},
  },
  clc,
  udc,
  id,
  discipline-level-1 = {
    default = {一级学科名称},
    name    = discipline@level@i,
  },
  discipline-level-2 = {
    default = {二级学科名称},
    name    = discipline@level@ii,
  },
  start-date = {
    name    = start@date,
    default = {\the\year-\two@digits{\month}-\two@digits{\day}},
  },
  end-date = {
    name    = end@date,
    default = {\the\year-\two@digits{\month}-\two@digits{\day}},
  },
  include-spine = {
    name = include@spine,
    choices = {
      false,
      true,
    },
    default = false,
  },
}
\newcommand\hnust@format@date[2]{%
  \edef\hnust@@date{#2}%
  \def\hnust@@process@date##1-##2-##3\@nil{%
    #1{##1}{##2}{##3}%
  }%
  \expandafter\hnust@@process@date\hnust@@date\@nil
}
\newcommand\hnust@date@zh@digit[3]{#1 年 \number#2 月 \number#3 日}
\newcommand\hnust@date@zh@digit@short[3]{#1 年 \number#2 月}
\newcommand\hnust@date@zh@short[3]{\zhdigits{#1}年\zhnumber{#2}月}
\newcommand\hnust@date@month[1]{%
  \ifcase\number#1\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December%
  \fi
}
\newcommand\hnust@date@en@short[3]{\hnust@date@month{#2}, #1}
\newcommand\hnust@underline[2][6em]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
\newcommand\hnust@CJKunderline[2][6em]{\CJKunderline*{\hb@xt@ #1{\hss#2\hss}}}
\newcommand\hnust@fixed@box[2]{%
  \begingroup
    \def\CJKglue{\hskip 0pt plus 2filll minus 1filll}%
    \makebox[#1][l]{#2}%
  \endgroup
}
\newbox\hnust@stretch@box
\newcommand\hnust@stretch[2]{%
  \sbox\hnust@stretch@box{#2}%
  \ifdim \wd\hnust@stretch@box < #1\relax
    \begingroup
      \def\CJKglue{\hskip 0pt plus 2filll}%
      \makebox[#1][l]{#2}%
    \endgroup
  \else
    \box\hnust@stretch@box
  \fi
}
\newbox\hnust@pad@box
\newcommand\hnust@pad[2]{%
  \sbox\hnust@pad@box{#2}%
  \ifdim \wd\hnust@pad@box < #1\relax
    \makebox[#1][l]{\box\hnust@pad@box}%
  \else
    \box\hnust@pad@box
  \fi
}
\newcounter{hnust@csl@count}
\newcommand\hnust@name@title@process[1]{%
  \ifcase\c@hnust@csl@count  % == 0
    \gdef\hnust@@name{#1}%
  \or  % == 1
    \gdef\hnust@@title{#1}%
  \fi
  \stepcounter{hnust@csl@count}%
}
\newcommand\hnust@name@title@format[2]{%
  \hnust@pad{3cm}{\hnust@stretch{4em}{#1}}%
  \hnust@stretch{3em}{#2}%
}
\newcommand\hnust@name@title[1]{%
  \setcounter{hnust@csl@count}{0}%
  \gdef\hnust@@name{}%
  \gdef\hnust@@title{}%
  \expandafter\comma@parse\expandafter{#1}{\hnust@name@title@process}%
  \hnust@name@title@format{\hnust@@name}{\hnust@@title}%
}
\renewcommand\maketitle{%
  \cleardoublepage
  \pagenumbering{Alph}%
  \hnust@pdfbookmark{-1}{\hnust@title}%
  \hnust@titlepage
  \ifhnust@include@spine@true
    \hnust@spine
  \fi
  \ifhnust@degree@graduate
    \cleardoublepage
    \hnust@titlepage@en
  \fi
  \clearpage
}
\newcommand\hnust@titlepage{%
  \hnustsetup{language = chinese}%
  \ifhnust@degree@graduate
    \ifhnust@degree@type@academic
      \hnust@titlepage@graduate@academic
    \else
      \ifx\hnust@discipline\@empty
        \hnust@titlepage@graduate@professional
      \else
        \hnust@titlepage@graduate@academic
      \fi
    \fi
  \else
    \ifhnust@degree@bachelor
      \hnust@titlepage@bachelor
    \else
      \ifhnust@degree@postdoc
        \hnust@cover@postdoc
        \cleardoublepage
        \hnust@titlepage@postdoc
      \fi
    \fi
  \fi
  \hnust@reset@main@language
}
\newcommand\hnust@titlepage@graduate@academic{%
  \newgeometry{
    top     = 2cm,
    bottom  = 6cm,
    hmargin = 3.5cm,
  }%
  \thispagestyle{empty}%
  \null\vskip 0.2cm%
  \begingroup
    \centering
    \parbox[t][2cm][t]{\textwidth}{%
      \hskip -0.69cm%
      \hnust@titlepage@secret
    }\par
    \vskip 1.5cm%
    {\hnust@titlepage@title}%
    \vskip 0.85cm%
    \hnust@titlepage@degree
    \vfill
    \parbox[t][7.25cm][t]{\textwidth}{\centering\hnust@titlepage@info}\par
    \parbox[t][1.03cm][t]{\textwidth}{\centering\hnust@titlepage@date}\par
  \endgroup
  \clearpage
  \restoregeometry
}
\newcommand\hnust@titlepage@graduate@professional{%
  \newgeometry{
    top     = 2cm,
    bottom  = 6cm,
    hmargin = 3.5cm,
  }%
  \thispagestyle{empty}%
  \null\vskip 0.45cm%
  \begingroup
    \centering
    \parbox[t][1.52cm][t]{\textwidth}{%
      \hskip -0.69cm%
      \hnust@titlepage@secret
    }\par
    \vskip 1.5cm%
    {\sffamily\yihao[1.575]\hnust@title\par}%
    \vskip 0.9cm%
    \hnust@titlepage@degree
    \vfill
    \parbox[t][5.28cm][t]{\textwidth}{\centering\hnust@titlepage@info}\par
    \parbox[t][1.25cm][t]{\textwidth}{\centering\hnust@titlepage@date}\par
  \endgroup
  \clearpage
  \restoregeometry
}
\newcommand\hnust@titlepage@secret{%
  \sffamily\sanhao
  \ifx\hnust@secret@level\@empty
    \phantom{秘密}%
  \else
    \hnust@secret@level★\makebox[3em][c]{\hnust@secret@year}年%
  \fi\par
}
\newcommand\hnust@titlepage@title{%
  \sffamily\yihao[1.8]\hnust@title\par
}
\newcommand\hnust@titlepage@degree{%
  \begingroup
    \def\CJKglue{\hskip 1bp}%
    \CJKfamily+{}\xiaoer
    (申请清华大学\hnust@degree@name\ifhnust@degree@type@professional 专业\fi 学位论文)\par
  \endgroup
}
\newcommand\hnust@titlepage@info{%
  \ifhnust@degree@doctor
    \ifhnust@degree@type@academic
      \hnust@titlepage@info@doctor@academic
    \else
      \hnust@titlepage@info@doctor@professional
    \fi
  \else
    \ifhnust@degree@type@academic
      \hnust@titlepage@info@master@academic
    \else
      \ifx\hnust@discipline\@empty
        \hnust@titlepage@info@master@other
      \else
        \hnust@titlepage@info@master@engineer
      \fi
    \fi
  \fi
}
\newcommand\hnust@titlepage@info@tabular[4]{%
  \def\hnust@info@item##1##2##3{%
    \ifx##3\@empty\else
      \hnust@pad{#1}{\hnust@fixed@box{#2}{##1}}%
      \hnust@pad{#3}{：}%
      ##2{##3}\\
    \fi
  }%
  \fangsong\sanhao[1.95]%
  \begin{tabular}{l}%
    #4%
  \end{tabular}%
}
\newcommand\hnust@titlepage@info@doctor@academic{%
  \hnust@titlepage@info@tabular{2.8cm}{2.8cm}{0.82cm}{%
    \hnust@info@item{培养单位}{}{\hnust@department}%
    \hnust@info@item{学科}{}{\hnust@discipline}%
    \hnust@info@item{研究生}{\hnust@name@title}{\hnust@author}%
    \hnust@info@item{指导教师}{\hnust@name@title}{\hnust@supervisor}%
    \hnust@info@item{副指导教师}{\hnust@name@title}{\hnust@associate@supervisor}%
    \hnust@info@item{联合导师}{\hnust@name@title}{\hnust@joint@supervisor}%
  }\par
}
\newcommand\hnust@titlepage@info@doctor@professional{%
  \hnust@titlepage@info@tabular{3.03cm}{5em}{1.52cm}{%
    \hnust@info@item{培养单位}{}{\hnust@department}%
    \hnust@info@item{申请人}{\hnust@name@title}{\hnust@author}%
    \hnust@info@item{指导教师}{\hnust@name@title}{\hnust@supervisor}%
    \hnust@info@item{副指导教师}{\hnust@name@title}{\hnust@associate@supervisor}%
    \hnust@info@item{联合导师}{\hnust@name@title}{\hnust@joint@supervisor}%
  }\par
}
\newcommand\hnust@titlepage@info@master@academic{%
  \hnust@titlepage@info@tabular{3.59cm}{5.5em}{0.82cm}{%
    \hnust@info@item{培养单位}{}{\hnust@department}%
    \hnust@info@item{学科}{}{\hnust@discipline}%
    \hnust@info@item{研究生}{\hnust@name@title}{\hnust@author}%
    \hnust@info@item{指导教师}{\hnust@name@title}{\hnust@supervisor}%
    \hnust@info@item{副指导教师}{\hnust@name@title}{\hnust@associate@supervisor}%
    \hnust@info@item{联合指导教师}{\hnust@name@title}{\hnust@joint@supervisor}%
  }\par
}
\newcommand\hnust@titlepage@info@master@engineer{%
  \hnust@titlepage@info@tabular{2.8cm}{2.8cm}{1.34cm}{%
    \hnust@info@item{培养单位}{}{\hnust@department}%
    \hnust@info@item{工程领域}{}{\hnust@discipline}%
    \hnust@info@item{申请人}{\hnust@name@title}{\hnust@author}%
    \hnust@info@item{指导教师}{\hnust@name@title}{\hnust@supervisor}%
    \hnust@info@item{副指导教师}{\hnust@name@title}{\hnust@associate@supervisor}%
    \hnust@info@item{联合指导教师}{\hnust@name@title}{\hnust@joint@supervisor}%
  }\par
}
\newcommand\hnust@titlepage@info@master@other{%
  \hnust@titlepage@info@tabular{3.28cm}{5em}{1.52cm}{%
    \hnust@info@item{培养单位}{}{\hnust@department}%
    \hnust@info@item{申请人}{\hnust@name@title}{\hnust@author}%
    \hnust@info@item{指导教师}{\hnust@name@title}{\hnust@supervisor}%
    \hnust@info@item{副指导教师}{\hnust@name@title}{\hnust@associate@supervisor}%
    \hnust@info@item{联合指导教师}{\hnust@name@title}{\hnust@joint@supervisor}%
  }\par
}
\newcommand\hnust@titlepage@date{%
  \begingroup
    \def\CJKglue{\hskip 1bp}%
    \sanhao\hnust@format@date{\hnust@date@zh@short}{\hnust@date}\par
  \endgroup
}
\newcommand{\hnust@titlepage@en}{%
  \newgeometry{
    top     = 5.5cm,
    bottom  = 5cm,
    hmargin = 3.6cm,
  }%
  \thispagestyle{empty}%
  \hnustsetup{language = english}%
  \ifhnust@degree@type@academic
    \hnust@titlepage@en@graduate@academic
  \else
    \hnust@titlepage@en@graduate@professional
  \fi
  \hnust@reset@main@language
  \clearpage
  \restoregeometry
}
\newcommand\hnust@titlepage@en@graduate@academic{%
  \begingroup
    \centering
    \null\vskip -0.7cm%
    \hnust@titlepage@en@title
    \vfill
    \sanhao[1.725]%
    \hnust@titlepage@en@degree
    \vskip 0.13cm%
    in\par
    \vskip 0.1cm%
    {\bfseries\sffamily\hnust@discipline@en\par}
    \vskip 0.7cm%
    {\sffamily by\par}
    \vskip 0.24cm%
    {\sffamily\bfseries\hnust@author@en\par}%
    \vskip 0.14cm%
    \parbox[t][3.07cm][t]{\textwidth}{%
      \centering\xiaosan[2.1]%
      \hnust@titlepage@en@supervisor
    }\par
    \hnust@titlepage@en@date
    \vskip 0.65cm%
  \endgroup
}
\newcommand\hnust@titlepage@en@graduate@professional{%
  \begingroup
    \centering
    \null\vskip -0.7cm%
    \hnust@titlepage@en@title
    \vfill
    \sanhao[1.725]%
    \hnust@titlepage@en@degree
    \vskip 1.1cm%
    {\sffamily by\par}
    \vskip 0.24cm%
    {\sffamily\bfseries\hnust@author@en\par}%
    \ifx\hnust@discipline@en\empty
      \vskip 1.95cm%
    \else
      \vskip -0.1cm%
      {\sffamily\bfseries(\hnust@discipline@en)\par}%
      \vskip 1.1cm%
    \fi
    \parbox[t][3.37cm][t]{\textwidth}{%
      \centering\xiaosan[1.82]%
      \hnust@titlepage@en@supervisor
    }\par
    \hnust@titlepage@en@date
    \vskip 0.3cm%
  \endgroup
}
\newcommand\hnust@titlepage@en@title{%
  \begingroup
    \sffamily\bfseries\fontsize{20bp}{31bp}\selectfont
    \hnust@title@en\par
  \endgroup
}
\newcommand\hnust@thesis@name@en{%
  \ifhnust@degree@master
    Thesis%
  \else
    Dissertation%
  \fi
}
\newcommand\hnust@titlepage@en@degree{%
  \hnust@thesis@name@en{} Submitted to\par
  {\bfseries Tsinghua University\par}%
  in partial fulfillment of the requirement\par
  for the
  \ifhnust@degree@type@professional
    professional
  \fi
  degree of\par
  {\sffamily\bfseries\hnust@degree@name@en\par}%
}
\newcommand\hnust@titlepage@en@supervisor{%
  \begin{tabular}{r@{\makebox[0.71cm][l]{:}}l}%
    \hnust@thesis@name@en{} Supervisor & \hnust@supervisor@en     \\
    \ifx\hnust@associate@supervisor@en\@empty\else
      Associate Supervisor            & \hnust@associate@supervisor@en \\
    \fi
    \ifx\hnust@joint@supervisor@en\@empty\else
      Cooperate Supervisor            & \hnust@joint@supervisor@en   \\
    \fi
  \end{tabular}%
}
\newcommand\hnust@titlepage@en@date{%
  \begingroup
    \sffamily\bfseries\sanhao
    \hnust@format@date{\hnust@date@en@short}{\hnust@date}\par
  \endgroup
}
\newcommand\hnust@titlepage@bachelor{%
  \newgeometry{
    vmargin = 2.54cm,
    hmargin = 3.17cm,
  }%
  \thispagestyle{empty}%
  \begingroup
    \centering
    \parbox[t][0cm][t]{\textwidth}{%
      \hfill
      \xiaosi
      \ifx\hnust@secret@level\@empty\else
        \hnust@secret@level\space\hnust@secret@year 年\par
      \fi
    }%
  \endgroup
  \vfill
  \begingroup
    \centering
    \includegraphics{tsinghua-name-bachelor.pdf}%
    \vskip 0.94cm%
    {\sffamily\bfseries\xiaochu\ziju{0.5}综合论文训练\par}%
  \endgroup
  \vskip 1.8cm%
  \begingroup
    \heiti
    \ifhnust@main@language@chinese
      \yihao[1.56]%
    \else
      \fontsize{26bp}{32bp}\selectfont
    \fi
    \parindent=18bp%
    \hangindent=72bp%
    \makebox[54bp]{\xiaoer[1.2]题目：}%
    \CJKunderline*[skip=false, thickness=0.05em, depth=0.12em]{\hnust@title}%
    \ifhnust@main@language@english
      \\
      \hnustsetup{language=english}%
      \ul\hnust@title@en
      \hnustsetup{language=chinese}%
    \fi
    \par
  \endgroup
  \vskip 1.9cm%
  \begingroup
    \fangsong\sanhao[2.32]%
    \leftskip=2.5cm%
    \parindent=\z@
    \def\hnust@info@item##1##2##3{%
      \ifx##3\@empty\else
        \hnust@fixed@box{%
          \ifx\hnust@joint@supervisor\@empty
            4em%
          \else
            5.5em%
          \fi
        }{##1}：##2{##3}\par
      \fi
    }%
    \def\hnust@name@title@format##1##2{%
      \hnust@stretch{3em}{##1}\quad ##2%
    }%
    \hnust@info@item{系别}{}{\hnust@department}%
    \hnust@info@item{专业}{}{\hnust@discipline}%
    \hnust@info@item{姓名}{\hnust@name@title}{\hnust@author}%
    \hnust@info@item{指导教师}{\hnust@name@title}{\hnust@supervisor}%
    \hnust@info@item{辅导教师}{\hnust@name@title}{\hnust@associate@supervisor}%
    \hnust@info@item{联合指导教师}{\hnust@name@title}{\hnust@joint@supervisor}%
  \endgroup
  \vskip 1.4cm%
  \begingroup
    \centering
    {\CJKfamily+{}\xiaosi\hnust@format@date{\hnust@date@zh@digit}{\hnust@date}\par}%
  \endgroup
  \vfill
  \clearpage
  \restoregeometry
}
\newcommand\hnust@cover@postdoc{%
  \thispagestyle{empty}%
  \begin{center}%
    \renewcommand\ULthickness{0.7pt}%
    \vspace*{0.35cm}%
    {\sihao[2.6]%
      \hnust@stretch{3.1em}{分类号}\hnust@underline[3.7cm]{\hnust@clc}\hfill
      密级\hnust@underline[3.7cm]{\hnust@secret@level}\par
      \hnust@stretch{3.1em}{U D C}\hnust@underline[3.7cm]{\hnust@udc}\hfill
      编号\hnust@underline[3.7cm]{\hnust@id}\par
    }%
    \vskip 3.15cm%
    {\sffamily\bfseries\xiaoer[2.6]%
      {\ziju{1.5}清华大学\par}%
      {\ziju{0.5}博士后研究工作报告\par}%
    }%
    \vskip 0.2cm%
    \parbox[t][4.0cm][c]{\textwidth}{%
      \centering\sihao[3.46]\CJKunderline*[depth=1em]{\hnust@title}\par
    }\par
    \vskip 0.4cm%
    {\xiaosi\hnust@author\par}%
    \vskip 1.4cm%
    {\xiaosi[1.58]\xeCJKsetup{underline/depth=0.9em}%
      工作完成日期\quad
      \hnust@CJKunderline[5.9cm]{%
        \hnust@format@date{\hnust@date@zh@digit@short}{\hnust@start@date}—%
        \hnust@format@date{\hnust@date@zh@digit@short}{\hnust@end@date}
      }\par
      \vskip 0.55cm%
      报告提交日期\quad
      \hnust@CJKunderline[5.9cm]{\hnust@format@date{\hnust@date@zh@digit@short}{\hnust@date}}\par
    }%
    \vskip 0.45cm%
    {\xiaosi[2]{\ziju{1}清华大学}\quad （北京）\par}%
    \vskip 0.25cm%
    {\xiaosi[2]\hnust@format@date{\hnust@date@zh@digit@short}{\hnust@date}\par}%
  \end{center}%
}
\newcommand\hnust@titlepage@postdoc{%
  \thispagestyle{empty}%
  \begin{center}%
    \vspace*{1.5cm}%
    \parbox[t][3cm][c]{\textwidth}{%
      \centering\sanhao[1.95]\hnust@title\par
    }\par
    \vskip 0.15cm%
    \parbox[t][3cm][c]{\textwidth}{%
      \centering\sihao[1.36]\hnust@title@en\par
    }\par
    \vskip 0.4cm%
    {\xiaosi[2.6]%
      \begin{tabular}{l@{\quad}l}%
        \hnust@stretch{11em}{博士后姓名}                  & \hnust@author           \\
        \hnust@stretch{11em}{流动站（一级学科）名称}      & \hnust@discipline@level@i  \\
        \hnust@stretch{11em}{专\quad{}业（二级学科）名称} & \hnust@discipline@level@ii \\
      \end{tabular}\par
    }%
    \vskip 2.7cm%
    {\xiaosi[2.6]%
      研究工作起始时间\quad\hnust@format@date{\hnust@date@zh@digit}{\hnust@start@date}\par
      \vskip 0.1cm%
      研究工作期满时间\quad\hnust@format@date{\hnust@date@zh@digit}{\hnust@end@date}\par
    }%
    \vskip 2.1cm%
    {\xiaosi[2.6]清华大学人事部（北京）\par}%
    \vskip 0.6cm%
    {\wuhao\hnust@format@date{\hnust@date@zh@digit@short}{\hnust@date}\par}%
  \end{center}%
}
\def\hnust@committee@name{学位论文指导小组、公开评阅人和答辩委员会名单}
\newenvironment{committee}[1][]{%
  \cleardoublepage
  \let\hnust@committee@file\@empty
  \kv@define@key{hnust@committee}{name}{\let\hnust@committee@name\kv@value}%
  \kv@define@key{hnust@committee}{file}{\let\hnust@committee@file\kv@value}%
  \kv@set@family@handler{hnust@committee}{%
    \ifx\kv@value\relax
      \let\hnust@committee@file\kv@key
    \else
      \kv@handled@false
    \fi
  }%
  \kvsetkeys{hnust@committee}{#1}%
  \ifx\hnust@committee@file\@empty
    \hnust@chapter*[]{\hnust@committee@name}%
  \else
    \hnust@pdfbookmark{0}{\hnust@committee@name}%
    \includepdf{\hnust@committee@file}%
  \fi
  \thispagestyle{empty}%
  \ctexset{
    section = {
      format    += {\centering},
      numbering = false,
      afterindent = false,
    },
  }%
}{%
}
\newcommand\copyrightpage[1][]{%
  \ifhnust@degree@postdoc\relax\else
    \def\hnust@@tmp{#1}
    \ifx\hnust@@tmp\@empty
      \ifhnust@degree@bachelor
        \hnust@copyright@page@bachelor
      \else
        \hnust@copyright@page@graduate
      \fi
    \else
      \cleardoublepage
      \thispagestyle{empty}%
      \hnust@pdfbookmark{0}{\hnust@authorization@title}%
      \hnust@phantomsection
      \kv@define@key{hnust@copyright}{file}{\includepdf{\kv@value}}%
      \kv@set@family@handler{hnust@copyright}{%
        \ifx\kv@value\relax
          \includepdf{\kv@key}%
        \else
          \kv@handled@false
        \fi
      }%
      \kvsetkeys{hnust@copyright}{#1}%
    \fi
  \fi
}
\newcommand{\hnust@authorization@frontdate}{%
  日\ifhnust@degree@bachelor\hspace{1em}\else\hspace{2em}\fi 期：}
\newcommand\hnust@copyright@page@graduate{%
  \cleardoublepage
  \newgeometry{
    vmargin = 3.8cm,
    hmargin = 3.2cm,
  }%
  \begingroup
    \ctexset{
      chapter = {
        format     = {\centering\sffamily\erhao},
        beforeskip = 18bp,
        afterskip  = 6bp,
      },
    }%
    \hnust@chapter*[]{关于学位论文使用授权的说明}%
    \thispagestyle{empty}%
  \endgroup
  \vskip 50bp%
  \begingroup
    \fontsize{14bp}{26bp}\selectfont
    本人完全了解清华大学有关保留、使用学位论文的规定，即：\par
    清华大学拥有在著作权法规定范围内学位论文的使用权，其中包括：%
    （1）已获学位的研究生必须按学校规定提交学位论文，%
    学校可以采用影印、缩印或其他复制手段保存研究生上交的学位论文；%
    （2）\nobreak 为教学和科研目的，学校可以将公开的学位论文作为资料在图书馆、资料室等场所供校内师生阅读，%
    或在校园网上供校内师生浏览部分内容；%
    \ifhnust@degree@doctor
      （3）根据《中华人民共和国学位条例暂行实施办法》及上级教育主管部门具体要求，向国家图书馆报送相应的学位论文。%
    \else
      （3）按照上级教育主管部门督导、抽查等要求，报送相应的学位论文。%
    \fi
    \par
    本人保证遵守上述规定。\par
    \vskip 6bp%
    \textbf{（保密的论文在解密后遵守此规定）}\par
  \endgroup
  \vskip1.2cm%
  \begingroup
    \noindent\xiaosi
    \hspace*{1.5cm}%
    作者签名：\hnust@underline[7em]\relax\hfill
    导师签名：\hnust@underline[7em]\relax\hspace*{1cm}\\[3pt]%
    \hspace*{1.5cm}%
    日\hspace{2em}期：\hnust@underline[7em]\relax\hfill
    日\hspace{2em}期：\hnust@underline[7em]\relax\hspace*{1cm}%
  \endgroup
  \clearpage
  \restoregeometry
}
\newcommand\hnust@copyright@page@bachelor{%
  \cleardoublepage
  \begingroup
    \ctexset{
      chapter = {
        format     = {\centering\sffamily\erhao[1]},
        beforeskip = 1bp,
        afterskip  = 24bp,
      },
    }%
    \hnust@chapter*[]{关于学位论文使用授权的说明}%
    \thispagestyle{empty}%
  \endgroup
  \vskip 4bp%
  本人完全了解清华大学有关保留、使用学位论文的规定，即：%
  学校有权保留学位论文的复印件，允许该论文被查阅和借阅；%
  学校可以公布该论文的全部或部分内容，可以采用影印、缩印或其他复制手段保存该论文。\par
  \textbf{(涉密的学位论文在解密后应遵守此规定)}\par
  \null\par
  \begingroup
    \centering
    签\quad 名：\hnust@underline[6em]{}%
    导师签名：\hnust@underline[6em]{}%
    日\quad 期\hnust@underline[6em]{}%
    \par
  \endgroup
}
\hnust@define@key{
  keywords,
  keywords* = {
    name = keywords@en,
  },
}
\newcommand\hnust@clist@use[2]{%
  \def\hnust@@tmp{}%
  \def\hnust@clist@processor##1{%
    \ifx\hnust@@tmp\@empty
      \def\hnust@@tmp{#2}%
    \else
      #2%
    \fi
    ##1%
  }%
  \expandafter\comma@parse\expandafter{#1}{\hnust@clist@processor}%
}
\newenvironment{abstract}{%
  \@mainmatterfalse
  \ifhnust@degree@bachelor
    \cleardoublepage
  \fi
  \hnustsetup{language = chinese}%
  \ifhnust@degree@graduate
    \hnust@chapter*{\sonti\xiaoer\textbf{\hnust@abstract@name}}%
  \else
    \hnust@chapter*[]{\xiaoer\textbf{\hnust@abstract@name}}%
  \fi
}{%
  \par
  \null\par
  % \ifhnust@degree@graduate
    \noindent
    {\heiti{关键词：}}%
  % \else
  %   \textbf{关键词：}%
  % \fi
  \xiaosi{\hnust@clist@use{\hnust@keywords}{；}}%
  \ifhnust@degree@bachelor
    \cleardoublepage
  \fi
  \hnust@reset@main@language % switch back to main language
}
\newenvironment{abstract*}{%
  \@mainmatterfalse
  \ifhnust@degree@bachelor
    \cleardoublepage
  \fi
  \hnustsetup{language = english}%
  \ifhnust@degree@graduate
    \hnust@chapter*{\hnust@abstract@name@en}%
  \else
    \hnust@chapter*[]{\hnust@abstract@name@en}%
  \fi
}{%
  \par
  \null\par
  % \ifhnust@degree@graduate
    \noindent
  % \fi
  \xiaosi\textbf{Keywords:}\space
  \hnust@clist@use{\hnust@keywords@en}{; }%
  \ifhnust@degree@graduate
    \vspace*{\stretch{1}}%
  \fi
  \ifhnust@degree@bachelor
    \cleardoublepage
  \fi
  \hnust@reset@main@language % switch back to main language
}
\newenvironment{denotation}[1][2.5cm]{%
  \ifhnust@degree@bachelor
    \cleardoublepage
  \fi
  \ifhnust@degree@graduate
    \hnust@chapter*{\hnust@denotation@name}%
  \else
    \hnust@chapter*[]{\hnust@denotation@name}%
  \fi
  \vskip-30bp\xiaosi[1.6]\begin{hnust@denotation}[labelwidth=#1]
}{%
  \end{hnust@denotation}
}
\newlist{hnust@denotation}{description}{1}
\setlist[hnust@denotation]{%
  nosep,
  font=\normalfont,
  align=left,
  leftmargin=!, % sum of the following 3 lengths
  labelindent=0pt,
  labelwidth=2.5cm,
  labelsep*=0.5cm,
  itemindent=0pt,
}
\newcommand{\hnust@statement@text}{本人郑重声明：所呈交的学位论文，是本人在导师指导下
  ，独立进行研究工作所取得的成果。尽我所知，除文中已经注明引用的内容外，本学位论
  文的研究成果不包含任何他人享有著作权的内容。对本论文所涉及的研究工作做出贡献的
  其他个人和集体，均已在文中以明确方式标明。}
\newcommand{\hnust@signature}{签\hspace{1em}名：}
\newcommand{\hnust@backdate}{日\hspace{1em}期：}
\newenvironment{acknowledgements}{%
  \@mainmatterfalse
  \ifhnust@degree@bachelor
    \cleardoublepage
  \fi
  \hnust@chapter*{\hnust@acknowledgements@name}%
}{%
  \ifhnust@degree@bachelor
    \cleardoublepage
  \fi
}
\hnust@define@key{
  statement-page-style = {
    name = statement@page@style,
    choices = {
      empty,
      plain,
    },
    default = empty,
  },
  statement-page-number = {
    name = statement@page@number,
    choices = {
      false,
      true,
    },
    default = false,
  },
}
\hnust@option@hook{statement-page-number}{%
  \ifhnust@statement@page@number@false
    \hnustsetup{statement-page-style=empty}%
  \else
    \hnustsetup{statement-page-style=plain}%
  \fi
  \hnust@warning{%
    The "statement-page-number" option is deprecated.
    Use "page-style" option of \protect\statement command instead%
  }%
}
\newcommand\statement[1][]{%
  \@mainmatterfalse
  \ifhnust@degree@bachelor
    \cleardoublepage
    \def\hnust@statement@name{声\hspace{2em}明}%
  \else
    \def\hnust@statement@name{声\hspace{1em}明}%
  \fi
  \let\hnust@statement@file\@empty
  \kv@define@key{hnust@statement}{page-style}{\hnustsetup{statement-page-style=##1}}%
  \kv@define@key{hnust@statement}{file}{\let\hnust@statement@file\kv@value}%
  \kv@set@family@handler{hnust@statement}{%
    \ifx\kv@value\relax
      \let\hnust@statement@file\kv@key
    \else
      \kv@handled@false
    \fi
  }%
  \kvsetkeys{hnust@statement}{#1}%
  \ifx\hnust@statement@file\@empty
    \hnust@chapter*{\hnust@statement@name}%
    \thispagestyle{\hnust@statement@page@style}%
    \hnust@statement@text\par
    \ifhnust@degree@graduate
      \vskip 2cm%
    \else
      \null\par
    \fi
    {\hfill\hnust@signature\hnust@underline[2.5cm]\relax
      \hnust@backdate\hnust@underline[2.5cm]\relax}%
  \else
    \includepdf[pagecommand={%
      \markboth{\hnust@statement@name}{}%
      \hnust@phantomsection
      \addcontentsline{toc}{chapter}{\hnust@statement@name}%
    }]{\hnust@statement@file}%
  \fi
  \ifhnust@degree@bachelor
    \cleardoublepage
  \fi
}
\let\acknowledgement\acknowledgements
\let\endacknowledgement\endacknowledgements
\def\hnust@listof#1{% #1: float type
  \setcounter{tocdepth}{2} % restore tocdepth in case being modified
  \@ifstar
    {\hnust@chapter*[]{\csname list#1name\endcsname}\@starttoc{\csname ext@#1\endcsname}}
    {\hnust@chapter*{\csname list#1name\endcsname}\@starttoc{\csname ext@#1\endcsname}}%
}
\renewcommand\listoffigures{%
  \hnust@listof{figure}%
}
\titlecontents{figure}
  [\z@]{}
  {\contentspush{\figurename~\thecontentslabel\quad}}{}
  {\nobreak\hnust@leaders\nobreak\hfil\thecontentspage}
\renewcommand\listoftables{%
  \hnust@listof{table}%
}
\titlecontents{table}
  [\z@]{}
  {\contentspush{\tablename~\thecontentslabel\quad}}{}
  {\hnust@leaders\thecontentspage}
\newcommand\listoffiguresandtables{%
  \hnust@chapter*{\songti\bfseries\sihao{\hnust@list@figure@table@name}}%
  \@starttoc{lof}%
  \par
  \null\par
  \@starttoc{lot}%
}
\def\ext@equation{loe}
\def\equcaption#1{%
  \addcontentsline{\ext@equation}{equation}%
                  {\protect\numberline{#1}}}
\newcommand\listofequations{\hnust@listof{equation}}
\titlecontents{equation}
  [0pt]{\addvspace{6bp}}
  {\hnust@equation@name~\thecontentslabel}{}
  {\nobreak\hnust@leaders\nobreak\thecontentspage}
\contentsuse{equation}{loe}
  \hnust@define@key{
    cite-style = {
      name = cite@style,
      choices = {
        super,
        inline,
        author-year,
      }
    }
  }
\PassOptionsToPackage{compress}{natbib}
\AtEndOfPackageFile*{natbib}{
  \DeclareRobustCommand\inlinecite{\@inlinecite}
  \def\@inlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
  \let\onlinecite\inlinecite
  \newcommand\bibstyle@super{%
    \bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}
  \newcommand\bibstyle@inline{%
    \bibpunct{[}{]}{,}{n}{,}{,}}
  \@namedef{bibstyle@author-year}{%
    \bibpunct{(}{)}{;}{a}{,}{,}}
  \hnust@option@hook{cite-style}{\@nameuse{bibstyle@\hnust@cite@style}}
  \@namedef{bibstyle@hnustthesis-numeric}{\citestyle{super}}
  \@namedef{bibstyle@hnustthesis-author-year}{\citestyle{author-year}}
  \@namedef{bibstyle@hnustthesis-bachelor}{\citestyle{super}}
  \@namedef{bibstyle@hnustthesis-inline}{\citestyle{inline}}
  \renewcommand\NAT@citesuper[3]{\ifNAT@swa
    \if*#2*\else#2\NAT@spacechar\fi
    % \unskip\kern\p@\textsuperscript{\NAT@@open#1\NAT@@close}%
    %  \if*#3*\else\NAT@spacechar#3\fi\else #1\fi\endgroup}
    \unskip\kern\p@\textsuperscript{\NAT@@open#1\NAT@@close\if*#3*\else#3\fi}%
    \else #1\fi\endgroup}
  \renewcommand\NAT@citenum%
      [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
          % #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close\else#1\fi\endgroup}
          #1\NAT@@close\textsuperscript{\if*#3*\else#3\fi}\else#1\fi\endgroup}
  \def\NAT@citexnum[#1][#2]#3{%
    \NAT@reset@parser
    \NAT@sort@cites{#3}%
    \NAT@reset@citea
    \@cite{\def\NAT@num{-1}\let\NAT@last@yr\relax\let\NAT@nm\@empty
      \@for\@citeb:=\NAT@cite@list\do
      {\@safe@activestrue
      \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
      \@safe@activesfalse
      \@ifundefined{b@\@citeb\@extra@b@citeb}{%
        {\reset@font\bfseries?}
          \NAT@citeundefined\PackageWarning{natbib}%
        {Citation `\@citeb' on page \thepage \space undefined}}%
      {\let\NAT@last@num\NAT@num\let\NAT@last@nm\NAT@nm
        \NAT@parse{\@citeb}%
        \ifNAT@longnames\@ifundefined{bv@\@citeb\@extra@b@citeb}{%
          \let\NAT@name=\NAT@all@names
          \global\@namedef{bv@\@citeb\@extra@b@citeb}{}}{}%
        \fi
        \ifNAT@full\let\NAT@nm\NAT@all@names\else
          \let\NAT@nm\NAT@name\fi
        \ifNAT@swa
        \@ifnum{\NAT@ctype>\@ne}{%
          \@citea
          \NAT@hyper@{\@ifnum{\NAT@ctype=\tw@}{\NAT@test{\NAT@ctype}}{\NAT@alias}}%
        }{%
          \@ifnum{\NAT@cmprs>\z@}{%
          \NAT@ifcat@num\NAT@num
            {\let\NAT@nm=\NAT@num}%
            {\def\NAT@nm{-2}}%
          \NAT@ifcat@num\NAT@last@num
            {\@tempcnta=\NAT@last@num\relax}%
            {\@tempcnta\m@ne}%
          \@ifnum{\NAT@nm=\@tempcnta}{%
            \@ifnum{\NAT@merge>\@ne}{}{\NAT@last@yr@mbox}%
          }{%
            \advance\@tempcnta by\@ne
            \@ifnum{\NAT@nm=\@tempcnta}{%
              % \ifx\NAT@last@yr\relax
              %   \def@NAT@last@yr{\@citea}%
              % \else
              %   \def@NAT@last@yr{--\NAT@penalty}%
              % \fi
              \def@NAT@last@yr{-\NAT@penalty}%
            }{%
              \NAT@last@yr@mbox
            }%
          }%
          }{%
          \@tempswatrue
          \@ifnum{\NAT@merge>\@ne}{\@ifnum{\NAT@last@num=\NAT@num\relax}{\@tempswafalse}{}}{}%
          \if@tempswa\NAT@citea@mbox\fi
          }%
        }%
        \NAT@def@citea
        \else
          \ifcase\NAT@ctype
            \ifx\NAT@last@nm\NAT@nm \NAT@yrsep\NAT@penalty\NAT@space\else
              \@citea \NAT@test{\@ne}\NAT@spacechar\NAT@mbox{\NAT@super@kern\NAT@@open}%
            \fi
            \if*#1*\else#1\NAT@spacechar\fi
            \NAT@mbox{\NAT@hyper@{{\citenumfont{\NAT@num}}}}%
            \NAT@def@citea@box
          \or
            \NAT@hyper@citea@space{\NAT@test{\NAT@ctype}}%
          \or
            \NAT@hyper@citea@space{\NAT@test{\NAT@ctype}}%
          \or
            \NAT@hyper@citea@space\NAT@alias
          \fi
        \fi
      }%
      }%
        \@ifnum{\NAT@cmprs>\z@}{\NAT@last@yr}{}%
        \ifNAT@swa\else
          % \@ifnum{\NAT@ctype=\z@}{%
          %   \if*#2*\else\NAT@cmt#2\fi
          % }{}%
          \NAT@mbox{\NAT@@close}%
          \@ifnum{\NAT@ctype=\z@}{%
            \if*#2*\else\textsuperscript{#2}\fi
          }{}%
        \fi
    }{#1}{#2}%
  }%
  \renewcommand\NAT@cite%
      [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
          % #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close\else#1\fi\endgroup}
          #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
  \def\NAT@citex%
    [#1][#2]#3{%
    \NAT@reset@parser
    \NAT@sort@cites{#3}%
    \NAT@reset@citea
    \@cite{\let\NAT@nm\@empty\let\NAT@year\@empty
      \@for\@citeb:=\NAT@cite@list\do
      {\@safe@activestrue
      \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
      \@safe@activesfalse
      \@ifundefined{b@\@citeb\@extra@b@citeb}{\@citea%
        {\reset@font\bfseries ?}\NAT@citeundefined
                  \PackageWarning{natbib}%
        {Citation `\@citeb' on page \thepage \space undefined}\def\NAT@date{}}%
      {\let\NAT@last@nm=\NAT@nm\let\NAT@last@yr=\NAT@year
        \NAT@parse{\@citeb}%
        \ifNAT@longnames\@ifundefined{bv@\@citeb\@extra@b@citeb}{%
          \let\NAT@name=\NAT@all@names
          \global\@namedef{bv@\@citeb\@extra@b@citeb}{}}{}%
        \fi
      \ifNAT@full\let\NAT@nm\NAT@all@names\else
        \let\NAT@nm\NAT@name\fi
      \ifNAT@swa\ifcase\NAT@ctype
        \if\relax\NAT@date\relax
          \@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}\NAT@date}%
        \else
          \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
              \ifx\NAT@last@yr\NAT@year
                \def\NAT@temp{{?}}%
                \ifx\NAT@temp\NAT@exlab\PackageWarningNoLine{natbib}%
                {Multiple citation on page \thepage: same authors and
                year\MessageBreak without distinguishing extra
                letter,\MessageBreak appears as question mark}\fi
                \NAT@hyper@{\NAT@exlab}%
              \else\unskip\NAT@spacechar
                \NAT@hyper@{\NAT@date}%
              \fi
          \else
            \@citea\NAT@hyper@{%
              \NAT@nmfmt{\NAT@nm}%
              \hyper@natlinkbreak{%
                \NAT@aysep\NAT@spacechar}{\@citeb\@extra@b@citeb
              }%
              \NAT@date
            }%
          \fi
        \fi
      \or\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
      \or\@citea\NAT@hyper@{\NAT@date}%
      \or\@citea\NAT@hyper@{\NAT@alias}%
      \fi \NAT@def@citea
      \else
        \ifcase\NAT@ctype
          \if\relax\NAT@date\relax
            \@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
          \else
          \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
              \ifx\NAT@last@yr\NAT@year
                \def\NAT@temp{{?}}%
                \ifx\NAT@temp\NAT@exlab\PackageWarningNoLine{natbib}%
                {Multiple citation on page \thepage: same authors and
                year\MessageBreak without distinguishing extra
                letter,\MessageBreak appears as question mark}\fi
                \NAT@hyper@{\NAT@exlab}%
              \else
                \unskip\NAT@spacechar
                \NAT@hyper@{\NAT@date}%
              \fi
          \else
            \@citea\NAT@hyper@{%
              \NAT@nmfmt{\NAT@nm}%
              \hyper@natlinkbreak{\NAT@spacechar\NAT@@open\if*#1*\else#1\NAT@spacechar\fi}%
                {\@citeb\@extra@b@citeb}%
              \NAT@date
            }%
          \fi
          \fi
        \or\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
        \or\@citea\NAT@hyper@{\NAT@date}%
        \or\@citea\NAT@hyper@{\NAT@alias}%
        \fi
        \if\relax\NAT@date\relax
          \NAT@def@citea
        \else
          \NAT@def@citea@close
        \fi
      \fi
      }}\ifNAT@swa\else
        % \if*#2*\else\NAT@cmt#2\fi
        \if\relax\NAT@date\relax\else\NAT@@close\fi
        \if*#2*\else\textsuperscript{#2}\fi
      \fi}{#1}{#2}}
  \renewcommand\bibsection{\hnust@chapter*{{\songti\sihao\textbf{\bibname}}}}
  \newcommand\hnust@set@bibliography@format{%
    \ifhnust@degree@bachelor
      \renewcommand\bibfont{\fontsize{10.5bp}{19.5bp}\selectfont}%
      % \setlength{\bibsep}{6bp \@plus 3bp \@minus 3bp}%
      % \ifhnust@main@language@chinese
      %   \setlength{\bibhang}{21bp}%
      % \else
      %   \setlength{\bibhang}{0.5in}%
      % \fi
    \else
      \renewcommand\bibfont{\fontsize{10.5bp}{16bp}\selectfont}%
      \setlength{\bibsep}{3bp \@plus 3bp \@minus 3bp}%
      \setlength{\bibhang}{21bp}%
    \fi
  }
  \hnust@set@bibliography@format
  \hnust@option@hook{degree}{\hnust@set@bibliography@format}
  \hnust@option@hook{main-language}{\hnust@set@bibliography@format}
  \patchcmd\thebibliography{%
    \clubpenalty4000%
  }{%
    \interlinepenalty=5000\relax
    \clubpenalty=10000\relax
  }{}{\hnust@patch@error{\thebibliography}}
  \patchcmd\thebibliography{%
    \widowpenalty4000%
  }{%
    \widowpenalty=10000\relax
  }{}{\hnust@patch@error{\thebibliography}}
  \def\@biblabel#1{[#1]\hfill}
  \renewcommand\NAT@bibsetnum[1]{%
    % \settowidth\labelwidth{\@biblabel{#1}}%
    % \setlength{\leftmargin}{\labelwidth}%
    % \addtolength{\leftmargin}{\labelsep}%
    \setlength{\leftmargin}{1cm}%
    \setlength{\itemindent}{\z@}%
    \setlength{\labelsep}{0.1cm}%
    \setlength{\labelwidth}{0.9cm}%
    \setlength{\itemsep}{\bibsep}
    \setlength{\parsep}{\z@}%
    \ifNAT@openbib
      \addtolength{\leftmargin}{\bibindent}%
      \setlength{\itemindent}{-\bibindent}%
      \setlength{\listparindent}{\itemindent}%
      \setlength{\parsep}{0pt}%
    \fi
  }
}
\AtEndOfPackageFile*{biblatex}{
  \AtBeginDocument{
    \ifthenelse{\equal{\blx@bbxfile}{apa}}{\def\bibname{REFERENCES}}{}
    \ifthenelse{\equal{\blx@bbxfile}{apa6}}{\def\bibname{REFERENCES}}{}
    \ifthenelse{\equal{\blx@bbxfile}{mla}}{\def\bibname{WORKS CITED}}{}
    \ifthenelse{\equal{\blx@bbxfile}{mla-new}}{\def\bibname{WORKS CITED}}{}
  }
  \DeclareRobustCommand\inlinecite{\parencite}
  \defbibheading{bibliography}[\bibname]{\hnust@chapter*{\bibname}}
  \newcommand\hnust@set@bibliography@format{%
    \ifhnust@degree@bachelor
      \renewcommand\bibfont{\fontsize{10.5bp}{17bp}\selectfont}%
      \setlength{\bibitemsep}{6bp \@plus 3bp \@minus 3bp}%
      \ifhnust@main@language@chinese
        \setlength{\bibhang}{21bp}%
      \else
        \setlength{\bibhang}{0.5in}%
      \fi
    \else
      \renewcommand\bibfont{\fontsize{10.5bp}{16bp}\selectfont}%
      \setlength{\bibitemsep}{3bp \@plus 3bp \@minus 3bp}%
      \setlength{\biblabelsep}{0.1cm}%
      \setlength{\bibhang}{21bp}%
    \fi
  }
  \hnust@set@bibliography@format
  \hnust@option@hook{degree}{\hnust@set@bibliography@format}
  \hnust@option@hook{main-language}{\hnust@set@bibliography@format}
}
\AtEndOfPackageFile*{apacite}{
  \AtBeginDocument{
    \hnust@set@chapter@names
  }
  \renewcommand\bibliographytypesize{\fontsize{10.5bp}{17bp}\selectfont}
  \setlength{\bibitemsep}{6bp}
  \ifhnust@main@language@chinese
    \setlength{\bibleftmargin}{21bp}
    \setlength{\bibindent}{-\bibleftmargin}
  \else
    \setlength{\bibleftmargin}{0.5in}
    \setlength{\bibindent}{-\bibleftmargin}
  \fi
  \def\st@rtbibchapter{%
    \if@numberedbib%
      \chapter{\bibname}%   e.g.,   6. References
    \else%
      \hnust@chapter*{\bibname}%   e.g.,   References
    \fi%
  }%
}
\g@addto@macro\appendix{%
  \@mainmattertrue
}
\hnust@define@key{
  toc-depth = {
    name = toc@depth,
  },
}
\hnust@option@hook{toc-depth}{%
  \protected@write\@auxout{}{%
    \string\ttl@writefile{toc}{%
      \protect\setcounter{tocdepth}{\hnust@toc@depth}%
    }%
  }%
  \addtocontents{lof}{\string\let\string\contentsline\string\ttl@gobblecontents}
  \addtocontents{lot}{\string\let\string\contentsline\string\ttl@gobblecontents}
  \addtocontents{loe}{\string\let\string\contentsline\string\ttl@gobblecontents}
}
\g@addto@macro\appendix{%
  \hnustsetup{
    toc-depth = 0,
  }%
}
\newenvironment{survey}{%
  \chapter{外文资料的调研阅读报告}%
  \hnustsetup{language = english}%
  \let\title\hnust@appendix@title
  \let\maketitle\hnust@appendix@maketitle
  \hnust@set@partial@toc@format
  \renewcommand\tableofcontents{%
    \section*{Contents}%
    \hnust@pdfbookmark{1}{Contents}%
    \printcontents[survey]{l}{1}[2]{}%
    \vskip 20bp%
  }%
  \renewcommand\bibname{参考文献}%
  \let\bibsection\hnust@appendix@bibsection
  \renewcommand\@bibunitname{\jobname-survey}%
  \let\bibliographystyle\defaultbibliographystyle
  \let\bibliography\hnust@appendix@bibliography
  \begin{bibunit}%
  \startcontents[survey]%
}{%
  \stopcontents[survey]%
  \end{bibunit}%
  \hnust@reset@main@language % restore language
}
\newenvironment{translation}{%
  \chapter{外文资料的书面翻译}%
  \hnustsetup{language = chinese}%
  \let\title\hnust@appendix@title
  \let\maketitle\hnust@appendix@maketitle
  \hnust@set@partial@toc@format
  \renewcommand\tableofcontents{%
    \section*{目录}%
    \hnust@pdfbookmark{1}{目录}%
    \printcontents[translation]{l}{1}[2]{}%
    \vskip 20bp%
  }%
  \def\bibsection{%
    \begingroup
      \ctexset{section/numbering=false}%
      \section{\bibname}%
    \endgroup
  }%
  \renewcommand\@bibunitname{\jobname-translation}%
  \let\bibliographystyle\defaultbibliographystyle
  \let\bibliography\hnust@appendix@bibliography
  \begin{bibunit}%
  \startcontents[translation]%
}{%
  \stopcontents[translation]%
  \end{bibunit}%
  \hnust@reset@main@language % restore language
}
\newenvironment{translation-index}{%
  \begin{bibunit}%
    \renewcommand\@bibunitname{\jobname-index}%
    \renewcommand\bibname{书面翻译对应的原文索引}%
    \let\bibsection\hnust@appendix@bibsection
}{%
  \end{bibunit}%
}
\DeclareRobustCommand\hnust@appendix@title[1]{\gdef\hnust@appendix@@title{#1}}
\newcommand\hnust@appendix@maketitle{%
  \par
  \begin{center}%
    \xiaosi[1.667]\hnust@appendix@@title
  \end{center}%
  \par
}
\newcommand\hnust@set@partial@toc@format{%
  \titlecontents{section}
    [\z@]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\hnust@leaders\thecontentspage}%
  \titlecontents{subsection}
    [1em]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\hnust@leaders\thecontentspage}%
  \titlecontents{subsubsection}
    [2em]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\hnust@leaders\thecontentspage}%
}
\newcommand\hnust@appendix@bibsection{%
  \par
  \vskip 20bp%
  \hnust@pdfbookmark{1}{\bibname}%
  \begingroup
    \centering
    \xiaosi[1.667]\bibname\par
  \endgroup
  \vskip 6bp%
}%
\newcommand\hnust@appendix@bibliography[1]{\putbib[#1]}
\newenvironment{resume}{%
  \@mainmatterfalse
  \hnust@chapter*{\hnust@resume@name}%
  \ctexset{
    section = {
      format    += \centering,
      numbering = false,
    },
    subsection = {
      format     = \sffamily\fontsize{14bp}{20bp}\selectfont,
      numbering  = false,
      aftertitle = \ifhnust@language@chinese ：\else :\fi,
    },
  }%
  \ifhnust@degree@bachelor
    \ifhnust@language@english
      \sffamily\fontsize{15bp}{20bp}\selectfont,
    \fi
  \fi
}{}
\newcommand\resumeitem[1]{%
  \hnust@error{The "\protect\resumeitem" is obsolete. Please update to the new format}%
}
\newcommand\researchitem[1]{%
  \hnust@error{The "\protect\researchitem" is obsolete. Please update to the new format}%
}
\newlist{achievements}{enumerate}{1}
\setlist[achievements]{
  label      = [\arabic*],
  align      = left,
  leftmargin = 10mm,
  topsep     = 6bp,
  parsep     = 0bp,
  partopsep  = 0bp,
  itemsep    = 6bp,
  labelsep   = !,
  before     = {
    \ifhnust@degree@graduate
      \fontsize{12bp}{16bp}\selectfont
    \fi
  },
  resume     = achievements,
}
\newenvironment{publications}{%
  \hnust@deprecate{"publications" environment}{"achievements"}%
  \begin{achievements}%
}{%
  \end{achievements}%
}
\newcommand\publicationskip{%
  \hnust@error{The "\protect\publicationskip" is obsolete. Do not use it}%
}
\newcommand{\record}[1]{%
  \let\hnust@record@file\@empty
  \kv@define@key{hnust@record}{file}{\let\hnust@record@file\kv@value}%
  \kv@set@family@handler{hnust@record}{%
    \ifx\kv@value\relax
      \let\hnust@record@file\kv@key
    \else
      \kv@handled@false
    \fi
  }%
  \kvsetkeys{hnust@record}{#1}%
  \ifx\hnust@record@file\@empty
    \hnust@error{File path of \protect\record\space is required}
  \fi
  \cleardoublepage
  \hnust@pdfbookmark{0}{综合论文训练记录表}%
  \includepdf[pages=-]{\hnust@record@file}%
}
\AtEndOfPackageFile*{hyperref}{
  \hypersetup{
    linktoc            = all,
    bookmarksdepth     = 2,
    bookmarksnumbered  = true,
    bookmarksopen      = true,
    bookmarksopenlevel = 1,
    bookmarksdepth     = 3,
    unicode            = true,
    psdextra           = true,
    breaklinks         = true,
    plainpages         = false,
    pdfdisplaydoctitle = true,
    hidelinks,
  }%
  \newcounter{hnust@bookmark}
  \renewcommand\hnust@pdfbookmark[2]{%
    \phantomsection
    \stepcounter{hnust@bookmark}%
    \pdfbookmark[#1]{#2}{hnustchapter.\thehnust@bookmark}%
  }
  \renewcommand\hnust@phantomsection{%
    \phantomsection
  }
  \pdfstringdefDisableCommands{
    \let\\\relax
    \let\quad\relax
    \let\hspace\@gobble
  }%
  \@ifpackagelater{hyperref}{2019/04/27}{}{%
    \g@addto@macro\psdmapshortnames{\let\mu\textmu}
  }%
  \ifhnust@main@language@chinese
    \hypersetup{
      pdflang = zh-CN,
    }%
  \else
    \hypersetup{
      pdflang = en-US,
    }%
  \fi
  \AtBeginDocument{%
    \ifhnust@main@language@chinese
      \hypersetup{
        pdftitle    = \hnust@title,
        pdfauthor   = \hnust@author,
        pdfsubject  = \hnust@degree@name,
        pdfkeywords = \hnust@keywords,
      }%
    \else
      \hypersetup{
        pdftitle    = \hnust@title@en,
        pdfauthor   = \hnust@author@en,
        pdfsubject  = \hnust@degree@name@en,
        pdfkeywords = \hnust@keywords@en,
      }%
    \fi
    \hypersetup{
      pdfcreator={\hnustthesis-v\version}}
  }%
}
\AtEndOfPackageFile*{nomencl}{
  \let\nomname\hnust@denotation@name
  \def\thenomenclature{\begin{denotation}[\nom@tempdim]}
  \def\endthenomenclature{\end{denotation}}
}
\AtEndOfPackageFile*{longtable}{
  \pretocmd\LT@array{%
    \fontsize{11bp}{14.3bp}\selectfont
    \renewcommand\arraystretch{1.4}%
  }{}{\hnust@patch@error{\LT@array}}
}
\AtEndOfPackageFile*{siunitx}{%
  \sisetup{
    group-minimum-digits = 4,
    separate-uncertainty = true,
    inter-unit-product   = \ensuremath{{}\cdot{}},
  }
  \newcommand\hnust@set@siunitx@language{%
    \ifhnust@language@chinese
      \sisetup{
        list-final-separator = { 和 },
        list-pair-separator  = { 和 },
        range-phrase         = {～},
      }%
    \else
      \ifhnust@language@english
        \sisetup{
          list-final-separator = { and },
          list-pair-separator  = { and },
          range-phrase         = { to },
        }%
      \fi
    \fi
  }
  \hnust@set@siunitx@language
  \hnust@option@hook{language}{\hnust@set@siunitx@language}
}
\AtEndOfPackageFile*{amsthm}{%
  \newtheoremstyle{hnust}
    {\z@}{\z@}
    {\normalfont}{\z@}
    {\normalfont\sffamily}{\hnust@theorem@separator}
    {0.5em}{}
  \theoremstyle{hnust}
  \newtheorem{assumption}{\hnust@assumption@name}[chapter]%
  \newtheorem{definition}{\hnust@definition@name}[chapter]%
  \newtheorem{proposition}{\hnust@proposition@name}[chapter]%
  \newtheorem{lemma}{\hnust@lemma@name}[chapter]%
  \newtheorem{theorem}{\hnust@theorem@name}[chapter]%
  \newtheorem{axiom}{\hnust@axiom@name}[chapter]%
  \newtheorem{corollary}{\hnust@corollary@name}[chapter]%
  \newtheorem{exercise}{\hnust@exercise@name}[chapter]%
  \newtheorem{example}{\hnust@example@name}[chapter]%
  \newtheorem{remark}{\hnust@remark@name}[chapter]%
  \newtheorem{problem}{\hnust@problem@name}[chapter]%
  \newtheorem{conjecture}{\hnust@conjecture@name}[chapter]%
  \renewenvironment{proof}[1][\hnust@proof@name]{\par
    \pushQED{\qed}%
    % \normalfont \topsep6\p@\@plus6\p@\relax
    \normalfont \topsep\z@\relax
    \trivlist
    \item[\hskip\labelsep
      %     \itshape
      % #1\@addpunct{.}]\ignorespaces
      \sffamily
      #1\@addpunct{\hnust@theorem@separator}]\ignorespaces
  }{%
    \popQED\endtrivlist\@endpefalse
  }
  \renewcommand\qedsymbol{\ensuremath{\QED}}
}
\AtEndOfPackageFile*{ntheorem}{%
  \theorembodyfont{\normalfont}%
  \theoremheaderfont{\normalfont\sffamily}%
  \theoremsymbol{\ensuremath{\QED}}%
  \newtheorem*{proof}{\hnust@proof@name}%
  \theoremstyle{plain}%
  \theoremsymbol{}%
  \theoremseparator{\hnust@theorem@separator}%
  \newtheorem{assumption}{\hnust@assumption@name}[chapter]%
  \newtheorem{definition}{\hnust@definition@name}[chapter]%
  \newtheorem{proposition}{\hnust@proposition@name}[chapter]%
  \newtheorem{lemma}{\hnust@lemma@name}[chapter]%
  \newtheorem{theorem}{\hnust@theorem@name}[chapter]%
  \newtheorem{axiom}{\hnust@axiom@name}[chapter]%
  \newtheorem{corollary}{\hnust@corollary@name}[chapter]%
  \newtheorem{exercise}{\hnust@exercise@name}[chapter]%
  \newtheorem{example}{\hnust@example@name}[chapter]%
  \newtheorem{remark}{\hnust@remark@name}[chapter]%
  \newtheorem{problem}{\hnust@problem@name}[chapter]%
  \newtheorem{conjecture}{\hnust@conjecture@name}[chapter]%
}
\PassOptionsToPackage{chapter}{algorithm}
\AtEndOfPackageFile*{algorithm}{
  \floatname{algorithm}{\hnust@algorithm@name}
  \g@addto@macro\appendix{\renewcommand*{\thealgorithm}{\thechapter-\arabic{algorithm}}}
  \renewcommand\listofalgorithms{%
    \hnust@listof{algorithm}%
  }
  \renewcommand\listalgorithmname{\hnust@list@algorithm@name}
  \def\ext@algorithm{loa}
  \contentsuse{algorithm}{loa}
  \titlecontents{algorithm}
    [\z@]{}
    {\contentspush{\fname@algorithm~\thecontentslabel\quad}}{}
    {\hnust@leaders\thecontentspage}
}
\PassOptionsToPackage{algochapter}{algorithm2e}
\AtEndOfPackageFile*{algorithm2e}{
  \renewcommand\algorithmcfname{\hnust@algorithm@name}
  \SetAlgoCaptionLayout{hnust@caption@font}
  \SetAlCapSty{relax}
  \SetAlgoCaptionSeparator{\hspace*{1em}}
  \SetAlFnt{\fontsize{11bp}{14.3bp}\selectfont}
  \renewcommand\listofalgorithms{%
    \hnust@listof{algorithmcf}%
  }
  \renewcommand\listalgorithmcfname{\hnust@list@algorithm@name}
  \def\ext@algorithmcf{loa}
  \contentsuse{algocf}{loa}
  \titlecontents{algocf}
    [\z@]{}
    {\contentspush{\algorithmcfname~\thecontentslabel\quad}}{}
    {\hnust@leaders\thecontentspage}
}
\AtEndOfPackageFile*{minted}{
  \g@addto@macro\appendix{\renewcommand*{\thelisting}{\thechapter-\arabic{listing}}}%
  \newcommand\hnust@set@listing@language{%
    \ifhnust@language@chinese
      \floatname{listing}{代码}%
    \else
      \floatname{listing}{Listing}%
    \fi
  }
  \hnust@set@listing@language
  \hnust@option@hook{language}{\hnust@set@listing@language}
}
\hnust@define@key{
  spine-font = {
    name = spine@font,
    default = {\sanhao},
  },
  spine-title = {
    name = spine@title,
  },
  spine-author = {
    name = spine@author,
  },
}
\newcommand*\CJKmovesymbol[1]{\raise.3em\hbox{#1}}
\newcommand*\CJKmove{%
  \punctstyle{plain}%
  \let\CJKsymbol\CJKmovesymbol
  \let\CJKpunctsymbol\CJKsymbol
}
\NewDocumentCommand{\spine}{
    O{
      \ifx\hnust@spine@title\@empty
        \hnust@title
      \else
        \hnust@spine@title
      \fi
    }
    O{
      \ifx\hnust@spine@author\@empty
        \hnust@author
      \else
        \hnust@spine@author
      \fi
    }}{%
  \clearpage
  \ifhnust@degree@bachelor
    \newgeometry{
      vmargin = 3cm,
      hmargin = 1cm,
    }%
  \else
    \newgeometry{
      vmargin = 5.5cm,
      hmargin = 1cm,
    }%
  \fi
  \thispagestyle{empty}%
  \ifhnust@main@language@chinese
    \hnust@pdfbookmark{0}{书脊}%
  \else
    \hnust@pdfbookmark{0}{Spine}%
  \fi
  \begingroup
    \noindent\hfill
    \rotatebox[origin=lt]{-90}{%
      \makebox[\textheight]{%
        \fangsong
        \addCJKfontfeatures*{RawFeature={vertical}}%
        \hnust@spine@font
        \CJKmove
        #1\hfill
        \hnust@stretch{4.5em}{#2}%
      }%
    }%
  \endgroup
  \clearpage
  \restoregeometry
}
\newcommand\hnust@input@spine{%
  \IfFileExists{spine.pdf}{}{%
    \immediate\write18{xelatex spine.tex}%
    \IfFileExists{spine.pdf}{}{%
      \hnust@error{Cannot find file "spine.pdf". Compile "spine.tex" first, or enable shell escape}%
    }%
  }%
  \includepdf[pages=1]{spine.pdf}%
}
\newcommand\hnust@spine{%
  \ifhnust@cjk@font@fandol
    \hnust@input@spine
  \else
    \ifhnust@cjk@font@noto
      \hnust@input@spine
    \else
      \spine
    \fi
  \fi
}
\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
\DeclareRobustCommand\file{\nolinkurl}
\DeclareRobustCommand\env{\textsf}
\DeclareRobustCommand\pkg{\textsf}
\DeclareRobustCommand\cls{\textsf}
\sloppy
\endinput
%%
%% End of file `hnustthesis.cls'.
