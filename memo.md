---
title: "Rユーザーのため!?のPython環境構築"
author: "km"
date: "2019-07-25"
output: 
  html_document: 
    keep_md: TRUE
---



##### Python環境構築(ｲﾏｺｺ)→[初めてのreticulate](memo2.html)

 

##### 実行環境


```
## [1] "macOS Mojave 10.14.3"
```

### 要件

・システムにプリインストールされているPythonと分けてインストールする事\
・**サンドボックス化**[^1]された複数の環境を持てる様にする事

[^1]: 外界と隔離されていて、その中でもしヤバいことが起きても、他には影響が出ない様になっている環境

これに加えて、**Rのreticulateパッケージからアクセスできる**ようにしたい。

### Python環境構築ことはじめ

Pythonでは互換性のない変更が（Pythonそれ自体のバージョンや、パッケージのバージョン更新の際に、また、時として過激に）行われるので、プロジェクトごとにサンドボックス化された仮想環境を作っておいて、適宜それらを切り替えて使う必要がある。

これを怠ると、**Python3系のプログラムをPython2系で走らせようとして爆死する**ぐらいならまだしも、**あるパッケージのバージョンを更新したら互換性が崩壊して丸ごと再起不能のゴミ山と化す**という真夏の夜にピッタリな本当にあった怖い話が生成される。

必要とされるのは、**(A) Python仮想環境を管理するツール**と**(B) パッケージを管理するツール**であるが、厄介なことにここにも多くの選択肢(ざっと挙げても`Anaconda`, `pyenv`, `virtualenv`, `venv`, `pip`, `Pipenv`など)と、それぞれの組み合わせや相性があるので、どれが何で何ができて何をしてはいけないのか、大変混乱する。

現時点では、(A)(B)を一括して**Pipenvで管理することをオススメ**し、以下詳細を紹介する。

RからPythonを呼び出す場合、`reticulate::use_virtualenv()`や`reticulate::use_condaenv()`という関数を(ついつい)使いたくなるのでこの２つに触れておく。

#### Anacondaの話

１つの解決策として、`Anaconda`に全てを委ねる、というものがある。\
仮想環境をpythonのバージョンを指定して作ると、一緒にある程度の基礎的なパッケージ群をまとめてインストールしてくれるのでストレスが少ない。切り替えも簡単。(A)仮想環境の管理を担う`pyenv`との相性がいい。などなど良いことづくめ。Pythonを使う様になって2年以上(Anaconda + pyenv)のセットアップを使ってきた。

問題は、(B)パッケージ管理ツールとして独自の`conda`を使っていること。のみならず、`pip`も使えること。`conda`それ自体は悪くないのだけど、`pip`に比べて対応するパッケージやバージョンの範囲が狭いので、痒いところに手を届かそうとすると`pip`を使うことになる。これが事故のものとで`conda`と`pip`の相性は最悪で、コンフリクトが生じると該当の仮想環境のみならずAnacondaで管理している全環境(のパッケージ依存関係)が壊れる可能性がある。結局のところ`Anaconda`はサンドボックス環境としてきちんと閉じていないという問題が残る。

#### virtualenvの話

`virtualenv`も(A)と(B)を両方できるツールだ。\
`Anaconda+pyenv`では、Pythonのインタープリタをそれぞれの環境に合わせて独立してインストールできるが、`virtualenv`ではすでにインストールされているPythonインタープリタ(のPath)を探してコピーする、という挙動をする。このため仮想環境中に新たなPythonをインストールすることはできない。(B)パッケージのインストールは標準の`pip`を使って行い、`virtualenv`はその切り替えを担う。

まとめると(A)と(B)を両方できるといいつつ、本当はできなくて、(A)(B)をセットにした環境を切り替える機能を担う、と言った方が正しい。

実際のところ、Python公式でないこと以外に特にデメリットはないが、Python公式から同等の機能を持った(持っているらしい)`venv`が提供されているので、それに比べてメリットがあるかと言われると疑問。

#### Pipenvの話

で、`Pipenv`はPython公式ツールで、`virtualenv`と`pip`(と`pyenv`)をいい感じにラップしてくれる管理ツールです。メリットは仮想環境がキチンとサンドボックス化されていることと、`Pipenv`さえ意識していれば基本的にはOKという点です。操作コマンドも直感的でとても分かりやすい。

`Pipfile`と`Pipfile.lock`(あと`.env`も使えますね)に環境情報(ここに依存関係を含めて管理情報がログされます)を保持しておくなど、プロジェクト管理のイロハはRstudioユーザーにとっては馴染みのあるものです。

ついでに`reticulate`からもアクセスは簡単です(後述)。

### 構築手順

##### anacondaを消す

1. 仮想環境を消す


```bash
conda info -e
conda remove -n <envname> --all
```

2. 削除ツールの実行


```bash
conda install anaconda-clean
anaconda-clean
```

3. bashの整形。

#### Homebrewのメンテナンス


```bash
brew doctor
brew update
brew upgrade
brew cleanup
```

→ command line toolsのinstallも済ませておく。(upgradeの際に入っていないと怒られるはず, `sudo xcodebuild -license`)

#### python(公式)を入れる

[python公式](https://www.python.org/)\
バージョンの選択は慎重に。

#### pipenvを入れる

pip3で入れてpathを通します。


```bash
pip3 install pipenv
echo 'export PIPENV_VENV_IN_PROJECT=true' >> ~/.bash_profile
```

#### 仮想環境を作る


```bash
cd <project root>

pipenv install        # 指定しないと↑の公式から入れたものが優先される

pipenv --python 3.7   # 無いものを指定するとpyenv経由でインストールする 

pipenv shell         # 仮想環境の中に入る
exit
```

installすると、rootに`.venv`フォルダと、`Pipfile`, `Pipfile.lock`が作られる。


`Pipfile`はテキストで編集可。下記のような内容になっている。


```eval
[[source]]
name = "pypi"
url = "https://pypi.org/simple"
verify_ssl = true

[dev-packages]

[packages]
numpy = "*"
pandas = "*"
...

[requires]
python_version = "3.7"
```

#### pkgsのインストール

reticulate側から正常に認識させるためには**numpyは必須**。


```bash
pipenv install numpy
pipenv install pandas
...
```

`pipenv install`は、`Pipfile`に記載されている内容か、無い場合は最新バージョンでパッケージをインストールする。\
その内容に基づいて詳細な情報を**自動で**`Pipfile.lock`に加える。(このプロセスが自動である事が大切)

・`Pipfile`の中の`[packages]`に追記されていることを確認する。\
・`Pipfile.lock`の内容も追加されていることを確認する。

`pipenv install`は、`pip`の文法と完全な互換性がある(らしいが`--proxy`が通らなかった: `export`でPROXYのpathを指定する)。

現在の仮想環境にインストールされているパッケージを確認。


```bash
pipenv run pip freeze
```

パッケージの依存関係を表示


```bash
pipenv graph 
```


##### Pythonインタープリタのアドレスを確認。


```bash
pipenv --venv
```

このpathをR側に投げます。

というわけで環境構築終わり。→[初めてのreticulate](memo2.html)

#### VScode

AnacondaならspyderというIDEが使えるけど、Pipenvにすると使えない。\
VScodeを導入する。

インストールしたら、拡張機能として`Python Extension Pack`を入れる。\

`.venv`を認識させるためにファイル>基本設定>設定で`"python.venvPath": ".venv",`を追加。


## refs

・[reticulate official](https://rstudio.github.io/reticulate/index.html)

・[Rおじさん、Pythonistaになる](https://uribo.hatenablog.com/entry/2017/07/16/100253)

・[macOSにPython環境を構築する（pyenv＋Anaconda）](https://qiita.com/tanuk1647/items/3cf2f4a348220d90c612)

・[macOSにPython環境を構築する（Python＋Pipenv）](https://qiita.com/tanuk1647/items/cad362af79f528a5c348)

・[macOS+RStudioで呼び出すPythonのバージョンを指定する](https://qiita.com/1sh1da/items/aba7193baf9694ec4908) 

・[condaとpip：混ぜるな危険](http://onoz000.hatenablog.com/entry/2018/02/11/142347)

・[pyenv、pyenv-virtualenv、venv、Anaconda、Pipenv。私はPipenvを使う。](https://qiita.com/KRiver1/items/c1788e616b77a9bad4dd#pyenv)

・[pip 19.1.1 documentation](https://pip.pypa.io/en/stable/user_guide/#installing-packages)

・[Windows + Python 3.6 + PipEnv + Visual Studio Code でPython開発環境](https://qiita.com/youkidkk/items/b6a6e39ee3a109001c75)

