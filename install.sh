#! /bin/zsh

ROUGE="\033[31;01m"
VERT="\033[32;01m"
JAUNE="\033[33;01m"
BLEU="\033[34;01m"
MAGENTA="\033[35;01m"
CYAN="\033[36;01m"
BLANC="\033[37;01m"
NEUTRE="\033[0m"

echo "Zsh Install..."

rm ~/.zshrc
ln -s $PWD/zshrc ~/.zshrc
echo -n "$VERT*$NEUTRE  .zshrc linked\t"
echo -e "${BLEU}[${VERT}OK${BLEU}]${NEUTRE}"

rm ~/.zsh
ln -s $PWD/zsh ~/.zsh
echo -n "$VERT*$NEUTRE  .zsh linked\t\t"
echo -e "${BLEU}[${VERT}OK${BLEU}]${NEUTRE}"

if [ "$SHELL" != "/bin/zsh" ]; then
  echo -n "$JAUNE*$NEUTRE  Your shell is $SHELL, change it.\t"
  echo -e "${BLEU}[${VERT}OK${BLEU}]${NEUTRE}"
else
  source ~/.zshrc
  echo -n "$VERT*$NEUTRE  Sourced.\t\t"
  echo -e "${BLEU}[${VERT}OK${BLEU}]${NEUTRE}"
fi

echo -e "Done."
