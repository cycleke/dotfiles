if [[ $OSTYPE == (linux-gnu|linux) ]]; then
	export GTK_IM_MODULE=fcitx5
	export QT_IM_MODULE=fcitx5
	export XMODIFIERS="@im=fcitx5"
fi
