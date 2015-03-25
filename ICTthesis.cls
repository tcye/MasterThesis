
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ICTthesis}[2008/07/01 ICT, CAS thesis document class, version 1.0.0]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   class and packages

%%%%%%%%%%%%%%%%%%%%
%% Options
%%%%%%%%%%%%%%%%%%%%

%% disable oneside option
\DeclareOption{oneside}{\OptionNotUsed}

%% bold
\newif\ifICT@Option@titlebold \ICT@Option@titleboldtrue
\DeclareOption{nbold}{\ICT@Option@titleboldfalse}

%% driver
\newif\ifICT@Option@dvipdfm \ICT@Option@dvipdfmtrue
\DeclareOption{dvips}{\ICT@Option@dvipdfmfalse}
\DeclareOption{dvipdfm}{\ICT@Option@dvipdfmtrue}

%% print version or electronic version
\newif\ifICT@Option@PrintVersion \ICT@Option@PrintVersiontrue
\DeclareOption{pversion}{\ICT@Option@PrintVersiontrue}
\DeclareOption{eversion}{\ICT@Option@PrintVersionfalse}

%% info
\newif\ifICT@Option@info \ICT@Option@infotrue
\DeclareOption{noinfo}{\ICT@Option@infofalse}

%% ref
\newif\ifICT@Option@ref@sort \ICT@Option@ref@sortfalse
\newif\ifICT@Option@ref@compress \ICT@Option@ref@compressfalse
\DeclareOption{refsort}{\ICT@Option@ref@sorttrue}
\DeclareOption{refcompress}
  {\ICT@Option@ref@sorttrue\ICT@Option@ref@compresstrue}

%% others
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%
%% load class and packages
%%%%%%%%%%%%%%%%%%%%

%% book
\LoadClass[a4paper,cs4size,twoside,openright,fntef,punct,fancyhdr,hyperref,UTF8]{ctexbook}

%% ifthen
\RequirePackage{ifthen}

%% ifpdf
\RequirePackage{ifpdf}

%% natbib
\ifICT@Option@ref@sort
  \ifICT@Option@ref@compress
    \RequirePackage[numbers,sort&compress]{natbib}
  \else
    \RequirePackage[numbers,sort]{natbib}
  \fi
\fi

%% hyperref
\ifpdf
  \RequirePackage[pdftex]{hyperref}
\else
  \ifICT@Option@dvipdfm
    \RequirePackage[dvipdfm]{hyperref}
  \else
    \RequirePackage[dvips]{hyperref}
  \fi
\fi

%% color
\ifICT@Option@PrintVersion\relax\else
  \RequirePackage{color}
\fi

%% config file
\AtEndOfPackage{\makeatletter\input{ICTthesis.def}\makeatother}
\AtEndOfPackage{\makeatletter\input{ICTthesis.cfg}\makeatother}

%%%%%%%%%%%%%%%%%%%%
%% setup packages
%%%%%%%%%%%%%%%%%%%%

%% hyperref
  % GBK -> Unicode
%\AtBeginDvi{\special{pdf:tounicode GBK-EUC-UCS2}}
  % setup
\ifICT@Option@PrintVersion
  \hypersetup{
    a4paper,
    %CJKbookmarks,
    bookmarksnumbered,
    plainpages    = false,
    pdfstartview  = FitH
  }
\else
  \definecolor{ICT@hypercolor@darkgreen}{rgb}{0.1,0.5,0.1}
  \hypersetup{
    a4paper,
    %CJKbookmarks,
    bookmarksnumbered,
    colorlinks,
    linkcolor     = blue,
    anchorcolor   = blue,
    citecolor     = blue,
    urlcolor      = ICT@hypercolor@darkgreen,
    plainpages    = false,
    pdfstartview  = FitH
  }
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   utilities

\DeclareRobustCommand{\ICT@toc@add}[1]
  {\phantomsection\addcontentsline{toc}{chapter}{#1}}

%% underline
\def\ICT@@underline[#1]#2{\CTEXunderline{\hbox to #1{\hfill{#2}\hfill}}}
\DeclareRobustCommand{\ICT@underline}
  {\@ifnextchar[\ICT@@underline\CTEXunderline}

%% bold (for title)
\ifICT@Option@titlebold
  \DeclareRobustCommand*{\ICT@bold@title}{\bfseries}
\else
  \DeclareRobustCommand*{\ICT@bold@title}{\relax}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    font

%% family
\DeclareRobustCommand*{\ICT@font@st}{\songti}
\DeclareRobustCommand*{\ICT@font@ht}{\heiti}
\DeclareRobustCommand*{\ICT@font@fs}{\fangsong}
\DeclareRobustCommand*{\ICT@font@ks}{\kaishu}
\DeclareRobustCommand*{\ICT@font@ls}{\lishu}
\DeclareRobustCommand*{\ICT@font@yy}{\youyuan}

%% size
\DeclareRobustCommand*{\ICT@font@zihao}[1]{\zihao{#1}}
\renewcommand*{\baselinestretch}{1.3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    document setting

%% page
\hoffset 0 mm
\voffset 0 mm
\ifICT@Option@PrintVersion
  \oddsidemargin 0.5 cm
  \evensidemargin -0.5 cm
\else
  \oddsidemargin 0 cm
  \evensidemargin 0 cm
\fi
\topmargin 0 pt
\headheight 15 pt
%\headsep
\textwidth 16 cm
\textheight 23.7 cm
%\footskip

%% par skip
\parskip 0.5ex plus 0.25ex minus 0.25ex

%% section level
\setcounter{secnumdepth}{4}

%% chapter
\CTEXsetup[name={\ICT@chapter@prenumber,\ICT@chapter@afternumber},
           number={\chinese{chapter}},
           format={\centering\ICT@bold@title\ICT@font@ht\ICT@font@zihao{3}},
           nameformat={},
           numberformat={},
           aftername={\quad},
           titleformat={},
           beforeskip={15pt},
           afterskip={12pt},
           indent={0pt}]{chapter}

%% chapter without number
\DeclareRobustCommand{\ICT@nchapter}[1]{\chapter*{#1}}

%% section
\CTEXsetup[name={,},
           number={\thesection},
           format={\raggedright\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-3}},
           nameformat={},
           numberformat={},
           aftername={\quad},
           titleformat={},
           beforeskip={-3ex plus -1ex minus -.2ex},
           afterskip={1.0ex plus .2ex},
           indent={0pt}]{section}

%% subsection
\CTEXsetup[name={,},
           number={\thesubsection},
           format={\raggedright\ICT@bold@title\ICT@font@ht\ICT@font@zihao{4}},
           nameformat={},
           numberformat={},
           aftername={\quad},
           titleformat={},
           beforeskip={-2.5ex plus -1ex minus -.2ex},
           afterskip={1.0ex plus .2ex},
           indent={0pt}]{subsection}

%% subsubsection
\CTEXsetup[name={,},
           number={\thesubsubsection},
           format={\raggedright\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-4}},
           nameformat={},
           numberformat={},
           aftername={\quad},
           titleformat={},
           beforeskip={-2ex plus -1ex minus -.2ex},
           afterskip={1.0ex plus .2ex},
           indent={0pt}]{subsubsection}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    figure and table

%% figure name
\CTEXoptions[figurename={\ICT@label@figure@cap}]

%% table name
\CTEXoptions[tablename={\ICT@label@table@cap}]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    head and foot

%% remove header from empty page
\renewcommand{\cleardoublepage}
  {\clearpage%
   \ifodd%
     \c@page%
   \else%
     \thispagestyle{empty}%
     \hbox{}\newpage%
     \if@twocolumn%
       \hbox{}\newpage%
     \fi%
   \fi}

%% label of even page header
\def\ICT@hdr@thesis
  {{\ICT@label@schoolmark}{\ICT@value@degreemark}{\ICT@label@thesis}}
\def\ICT@hdr@thesistitle
  {{\ICT@hdr@thesis\ICT@hdr@dash@prefix}------%
   {\ICT@hdr@dash@suffix\ICT@value@thesis@titlemark}}

%% set header
\pagestyle{fancy}
\fancyhf{}
\fancyhead[CE]{{\ICT@font@st\ICT@hdr@thesistitle}}
\fancyhead[CO]{{\ICT@font@st\leftmark}}
\fancyfoot[C]{{\ICT@font@st\thepage}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    chinese  cover

\DeclareRobustCommand{\ICT@make@title}
  {{\cleardoublepage\CTEXnoindent\thispagestyle{empty}%
   \begin{center}%
    \vskip 5pt%
       \hfill%
     \normalfont\ICT@font@st\ICT@font@zihao{-4}%
     \ICT@label@cover@confidential~%
     \ICT@underline[70pt]{\ICT@value@thesis@confidential}\hspace*{1em}%
    \vskip 5pt%
        \hfill%

    \vskip \stretch{2}%
     \normalfont\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-1}%
     \includegraphics[width=0.7\textwidth]{coverlogo.png}\\%
     \vskip 5pt%

     \ICT@value@degreemark\ICT@label@thesis%
    \vskip \stretch{2}%
     \normalfont\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-3}%
     \ICT@underline{\raisebox{0.7ex}{\hspace*{1em}\ICT@value@thesis@title\hspace*{1em}}}%

    \vskip \stretch{2}%
     \normalfont\ICT@font@st\bfseries\ICT@font@zihao{-4}%
     \setlength{\tabcolsep}{0pt}\renewcommand{\arraystretch}{1.5}%
     \begin{tabular}{lclllccl}%
     \ICT@label@cover@author & \multicolumn{7}{l}{\ICT@underline[310pt]{\ICT@value@author@name}}\\%
     \ICT@label@cover@advisor & \multicolumn{7}{l}{\ICT@underline[310pt]{\ICT@value@advisor@name~~~\ICT@value@advisor@title}}\\%
     & \multicolumn{7}{l}{\ICT@underline[310pt]{\ICT@value@advisor@institute}}\\%
     \ICT@label@cover@degree & \multicolumn{7}{l}{\ICT@underline[310pt]{\ICT@value@degree}}\\%
     \ICT@label@cover@major & \multicolumn{7}{l}{\ICT@underline[310pt]{\ICT@value@author@major}}\\%
    \ICT@label@cover@institute & \multicolumn{7}{l}{\ICT@underline[310pt]{\ICT@value@author@institute}}\\%
    \end{tabular}%
     \vskip 50pt%
     \ICT@value@thesis@defend@date
    \vskip \stretch{1}%
   \end{center}%
   \clearpage\thispagestyle{empty}%
   \ifICT@Option@info%
     \normalfont\ICT@font@zihao{5}\vspace*{\stretch{10}}%
     Typeset by \LaTeX{} with Package \texttt{ICTthesis}%
     \vspace*{\stretch{1}}\normalfont\ICT@font@zihao{-4}%
   \fi%
   \CTEXindent\cleardoublepage}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    english  cover

\DeclareRobustCommand{\ICT@make@titleenglish}
  {{\cleardoublepage\CTEXnoindent\thispagestyle{empty}%

   \begin{center}%
    \vskip 3pt%
       \hfill%
    \vskip \stretch{1}%
    \normalfont\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-3}%
     \hspace*{1em}\ICT@evalue@thesis@title\hspace*{1em}%
     \vskip \stretch{1}%
      \normalfont\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-3}
        By

        \ICT@evalue@author@name
    \vskip \stretch{1}%
    \normalfont\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-4}%
    \setlength{\tabcolsep}{0pt}\renewcommand{\arraystretch}{1.5}%
    A Dissertation Submitted to
     \vskip 3pt%
     Graduate University of Chinese Academy of Sciences
     \vskip 3pt%
    In partial fulfillment of the requirement
\vskip 3pt%
    For the degree of
\vskip 3pt%
    \ICT@evalue@degree

    \vskip \stretch{1}%

     \normalfont\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-3}%
     \ICT@evalue@author@institute

     \ICT@evalue@author@school

     \ICT@evalue@thesis@defend@date

   \end{center}%
    \vspace{1cm}
   \clearpage\thispagestyle{empty}%

   \CTEXindent\cleardoublepage}}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    statement and copyright

\DeclareRobustCommand{\ICT@make@statementandcopyright}
  {{\cleardoublepage\CTEXnoindent\thispagestyle{empty}%
   \renewcommand*{\baselinestretch}{1.8}%
   \begin{center}%
     \normalfont\ICT@font@st\bfseries\ICT@font@zihao{3}%
     \ICT@label@stat@statement%
   \end{center}%
   \normalfont\ICT@font@st\ICT@font@zihao{4}%
   \hspace*{2em}\CTEXindent\ICT@value@stat@statement\CTEXnoindent%
  \vskip 20pt%
   \normalfont\ICT@font@st\ICT@font@zihao{4}%
   \hspace*{\stretch{2}}\ICT@lable@stat@auther%
   \hspace{\stretch{2}}\ICT@lable@stat@date%
   \hspace*{\stretch{2}}%
  \vskip \stretch{2}%
   \begin{center}%
     \normalfont\ICT@font@st\bfseries\ICT@font@zihao{3}%
     \ICT@lable@stat@copyright%
   \end{center}%
   \normalfont\ICT@font@st\ICT@font@zihao{4}%
   \hspace*{2em}\CTEXindent\ICT@value@stat@copyright\CTEXnoindent%
  \vskip 20pt%
   \normalfont\ICT@font@st\ICT@font@zihao{4}%
   \hspace*{\stretch{1}}\ICT@lable@stat@auther%
   \hspace{\stretch{2}}\ICT@lable@stat@advisor%
   \hspace{\stretch{2}}\ICT@lable@stat@date%
   \hspace*{\stretch{2}}%
  \vskip \stretch{1}%
  \renewcommand*{\baselinestretch}{1.3}%
  \CTEXindent\cleardoublepage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    abstract

%% chinese abstract
\newenvironment{abstract}
  {\cleardoublepage\ICT@toc@add{\ICT@toc@abstract}%
   \ICT@nchapter{\ICT@label@abstract}}
  {}

%% chinese keywords
\DeclareRobustCommand{\keywords}[1]
  {{\CTEXnoindent\vspace{2ex}%
   \normalfont\ICT@font@st\bfseries\ICT@font@zihao{-4}%
   \ICT@label@keywords%
   \normalfont\ICT@font@st\ICT@font@zihao{-4}%
   {#1}\CTEXindent}}

%% english abstract
\newenvironment{englishabstract}
  {\ICT@nchapter{\normalfont\bfseries\ICT@font@zihao{-4}\ICT@evalue@thesis@title}%
   \vspace{-2ex}\CTEXnoindent\normalfont\ICT@font@zihao{-4}%
   \begin{center}%
     \ICT@evalue@author@name\ (\ICT@evalue@author@major)\\%
     Directed by \ICT@evalue@advisor@title{} \ICT@evalue@advisor@name%
   \end{center}\CTEXindent}
  {}

%% english keywords
\DeclareRobustCommand{\englishkeywords}[1]
  {{\CTEXnoindent\vspace{2ex}%
   \normalfont\ICT@font@st\bfseries\ICT@font@zihao{-4}%
   \ICT@elabel@keywords~%
   \normalfont\ICT@font@st\ICT@font@zihao{-4}%
   {#1}\CTEXindent}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    content

%% content
\CTEXoptions[contentsname={\ICT@label@content}]
\DeclareRobustCommand{\ICT@tableofcontents}
  {\cleardoublepage\ICT@toc@add{\ICT@toc@content}%
   \tableofcontents}

%% list of figures
\CTEXoptions[listfigurename={\ICT@label@listoffigures}]
\DeclareRobustCommand{\ICT@listoffigures}
  {\cleardoublepage\ICT@toc@add{\ICT@toc@listoffigures}%
   \listoffigures}

%% list of tables
\CTEXoptions[listtablename={\ICT@label@listoftables}]
\DeclareRobustCommand{\ICT@listoftables}
  {\cleardoublepage\ICT@toc@add{\ICT@toc@listoftables}%
   \listoftables}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    referrence

\CTEXoptions[bibname={\ICT@label@ref@title}]
\bibliographystyle{plain}

\renewenvironment{thebibliography}[1]
  {\cleardoublepage\ICT@toc@add{\ICT@toc@ref@title}%
   \ICT@nchapter{\bibname}%
   \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
   \list{\@biblabel{\@arabic\c@enumiv}}%
    {\settowidth\labelwidth{\@biblabel{#1}}%
     \leftmargin\labelwidth\advance\leftmargin\labelsep%
     \@openbib@code\usecounter{enumiv}\let\p@enumiv\@empty%
     \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy\clubpenalty4000\@clubpenalty\clubpenalty%
   \widowpenalty4000\sfcode`\.\@m}
  {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    thanks

\renewenvironment{thanks}
  {\cleardoublepage\ICT@toc@add{\ICT@toc@thanks}%
   \ICT@nchapter{\ICT@label@thanks}}
  {}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    resume

%% environment
\newenvironment{resume}
  {\CTEXnoindent\cleardoublepage\ICT@toc@add{\ICT@toc@resume@title}%
   \ICT@nchapter{\ICT@label@resume@title}%
   \normalfont\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-4}%
   \ICT@label@resume@baseinfo%
  \vskip 10pt%
   \normalfont\ICT@font@st\bfseries\ICT@font@zihao{-4}%
   \ICT@label@resume@name%
   \normalfont\ICT@font@st\ICT@font@zihao{-4}%
   \ICT@value@author@name%
     \hspace{\stretch{2}}%
   \normalfont\ICT@font@st\bfseries\ICT@font@zihao{-4}%
   \ICT@label@resume@sex%
   \normalfont\ICT@font@st\ICT@font@zihao{-4}%
   \ICT@value@author@gender%
     \hspace{\stretch{2}}%
   \normalfont\ICT@font@st\bfseries\ICT@font@zihao{-4}%
   \ICT@label@resume@birthday%
   \normalfont\ICT@font@st\ICT@font@zihao{-4}%
   \ICT@value@author@birthday%
     \hspace{\stretch{2}}%
   \normalfont\ICT@font@st\bfseries\ICT@font@zihao{-4}%
   \ICT@label@resume@place%
   \normalfont\ICT@font@st\ICT@font@zihao{-4}%
   \ICT@value@author@place%
     \hspace*{\stretch{1}}%
  \vskip 20pt\CTEXindent}
  {}

%% resume list
\newcounter{ICT@counter@resumelistcounter}
\newenvironment{resumelist}[1]
  {{\CTEXnoindent\normalfont\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-4}%
   {#1}\CTEXindent}%
   \begin{list}{[~\arabic{ICT@counter@resumelistcounter}~]}
    {\usecounter{ICT@counter@resumelistcounter}
     \setcounter{ICT@counter@resumelistcounter}{0}
     \CTEXnoindent\normalfont\ICT@font@st\ICT@font@zihao{-4}
     \setlength{\leftmargin}{1.25\labelwidth}}}
  {\end{list}\vskip 20pt}
\newenvironment{resumelist*}[1]
  {{\CTEXnoindent\normalfont\ICT@bold@title\ICT@font@ht\ICT@font@zihao{-4}%
   {#1}\CTEXindent}%
   \begin{list}{}
    {\CTEXnoindent\normalfont\ICT@font@st\ICT@font@zihao{-4}
     \setlength{\leftmargin}{0pt}}}
  {\end{list}\vskip 20pt}

%% resume list item
\DeclareRobustCommand{\resumelistitem}{\item{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    thesis structure

%% front matter
\DeclareRobustCommand{\ICTfrontmatter}
  {\ICT@make@title\ICT@make@titleenglish\ICT@make@statementandcopyright%
   \frontmatter\cleardoublepage\pagenumbering{Roman}}

%% main matter
\DeclareRobustCommand{\ICTmainmatter}
  {\ICT@tableofcontents\ICT@listoffigures%
   \ICT@listoftables\mainmatter}

%% back matter
\DeclareRobustCommand{\ICTbackmatter}[1]
  {\backmatter{}#1{}\cleardoublepage\pagenumbering{roman}}
