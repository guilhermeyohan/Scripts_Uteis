import random
import string

def gerar_senha(tamanho):
  # PT-BR Gera uma senha com tamanho caracteres, contendo letras, números e símbolos
  # EN-US Generates a character-sized password, containing letters, numbers and symbols
  senha = ''.join(random.choices(string.ascii_letters + string.digits + string.punctuation, k=tamanho))
  return senha

 # PT-BR Pede ao usuário para escolher o tamanho da senha
 # EN-US Asks the user to choose the password length
tamanho = int(input("Quantos caracteres você quer que a senha tenha? "))

# PT-BR Gera a senha
# EN-US Generate the password
senha = gerar_senha(tamanho)

# PT-BR Exibe a senha
# EN-US Show the password
print("Sua nova senha é:", senha)
