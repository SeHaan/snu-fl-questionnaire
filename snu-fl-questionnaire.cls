%%
%% This is file `snu-fl-questionnaire.cls'.
%%
%% -----------------------------------------------------------------
%% The snu-fl-questionnaire class --- A class for SNU Field Lingusitics questionnaires
%% Maintained by Junyoung Park
%% E-mail: bloomwayz@snu.ac.kr
%% Released under the MIT License.
%% -----------------------------------------------------------------
%%
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\RequirePackage{expl3}
\ProvidesExplClass
  {snu-fl-questionnaire}
  {2025/10/22}
  {0.1}
  {A class for SNU Field Lingusitics questionnaires}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load class %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions*
\LoadClass[a4paper,10pt,left,openany]{memoir}
\DoubleSpacing


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Base packages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{kotex}

\RequirePackage{xcolor}
\RequirePackage{graphicx}

\RequirePackage{tabularray}
\UseTblrLibrary{booktabs}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Font setup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{microtype}

% Works for pdfLaTeX, XeLaTeX, and LuaLaTeX
\RequirePackage{libertine}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Page layout configuration %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlrmarginsandblock{2cm}{2cm}{*}
\setulmarginsandblock{2cm}{2cm}{*}
\setheadfoot{0.5cm}{0.5cm}
\checkandfixthelayout


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Chapter style configuration %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makechapterstyle{customchap}{
  % Numbering style
  \renewcommand{\thechapter}{\Roman{chapter}}
  \renewcommand{\chapterheadstart}{
    \ifnum\value{chapter}=2
      \renewcommand{\thesection}{\arabic{section}.}
    \else
      \renewcommand{\thesection}{\Alph{section}.}
    \fi
  }

  % Section/subsection font
  \setsecheadstyle{\fontsize{12pt}{14pt}\selectfont\sffamily\bfseries\raggedright}
  \setsubsecheadstyle{\fontsize{10pt}{11pt}\selectfont\sffamily\bfseries\raggedright}

  \renewcommand{\printchaptername}{}
  \renewcommand{\afterchapternum}{.\space}
  \renewcommand{\chapnumfont}{\centering\fontsize{16pt}{19pt}\selectfont\sffamily\bfseries}
  \renewcommand{\chaptitlefont}{\centering\fontsize{16pt}{19pt}\selectfont\sffamily\bfseries}

  \setlength{\beforechapskip}{0pt}
  \setlength{\afterchapskip}{40pt}
}
\chapterstyle{customchap}

\setsecnumdepth{section}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Pagination / ToC configuration %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand*{\contentsname}{목차}
\renewcommand*\cftappendixname{부록~}
\settocdepth{chapter}

\copypagestyle{customruled}{plain}
\makeevenfoot{customruled}{\thepage{}~|~서울대학교~언어학과}{}{}
\makeoddfoot{customruled}{}{}{한국언어조사질문지~|~\thepage}
\pagestyle{customruled}

\aliaspagestyle{chapter}{customruled}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Watermark configuration %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[
  firstpageonly,
  angle=0,
  scale=0.75,
  text={\includegraphics{snu-ui-trans.png}}
]{draftwatermark}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Document metadata fields %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Additional Fields
\NewDocumentCommand \printdate { m }
  { \newcommand*\@printdate{#1} }

\NewDocumentCommand \issuedate { m }
  { \newcommand*\@issuedate{#1} }

\NewDocumentCommand \tel { m }
  { \newcommand*\@tel{#1} }

% Front title
\renewcommand{\maketitle}{
  \thispagestyle{empty}
  \DoubleSpacing
  \begin{center}
    \vspace*{1cm}
    \rule{300pt}{3pt}
    \par\vspace{-0.8\baselineskip}
    \fontsize{28pt}{30pt}\selectfont\sffamily\bfseries
    \@title
    \par\vspace{-0.6\baselineskip}
    \rule{300pt}{3pt}
    \vfill
    \fontsize{20pt}{22pt}\selectfont\sffamily\bfseries
    \@author \\
    \fontsize{18pt}{20pt}\selectfont\sffamily\mdseries
    \@date \\
    \vspace*{2cm} 
  \end{center}
  \newpage
}

% Back cover
\newcommand{\makebackcover}{
  \thispagestyle{empty}
  \selectfont\sffamily
  \null\vfill
  \begin{center}
    \setlength{\fboxrule}{0.4pt} 
    \setlength{\fboxsep}{20pt} 
    \fbox{
      \begin{tabular}{c}
        \strut \fontsize{15pt}{17pt}\selectfont\bfseries\@title \strut \\[2.5ex]
        \strut \fontsize{10pt}{11pt}\selectfont\mdseries\@printdate{}~인쇄 \strut \\
        \strut \@printdate{}~발행 \strut \\[2.5ex]
        \strut 엮은이:~\@author \strut \\
        \strut 전화:~\@tel \strut
      \end{tabular}
    }
    \vfill
  \end{center}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Macros %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Korean-English, e.g., \alt{형태의미론}{Morpho-Semantics}
% \alt*을 통해 찾아보기에 추가, \alt는 단순히 한영 병기
% <>안에는 참조할 다른 개념 제시

\NewDocumentCommand { \myindex } { s m m }
  {
    \IfBooleanTF {#1}
      { \index{#2!#3|textbf}\index{#3!#2|textbf} }
      { \index{#2!#3}\index{#3!#2} }
  }

\NewDocumentCommand { \alt } { s m O{#2} d<> m O{#5} d<> }
  {
    #2\,{\color{gray!50!darkgray}\smaller\textit{#5}}\hspace{.06667em}
    \IfBooleanT {#1}
      {
        \myindex{#3}{#6}

        \IfNoValueTF {#4}
          {
            \IfNoValueF {#7}
              { % See English
                \index{#6|see{#7}}
              }
          }
          {
             \IfNoValueTF {#7}
              { % See Korean
                \index{#3|see{#4}}
              }
              { % See both
                \index{#3|see{#4}}\index{#6|see{#7}}
              }
          }
      }
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Hyperref %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage[pdfusetitle]{hyperref}
\RequirePackage[noabbrev, nameinlink]{cleveref}
