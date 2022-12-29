import random
import string

def gerar_senha(tamanho):
  senha = ''.join(random.choices(string.ascii_letters + string.digits + string.punctuation, k=tamanho))
  return senha
tamanho = int(input("Quantos caracteres você quer que a senha tenha? "))
senha = gerar_senha(tamanho)
print("Sua nova senha é:", senha)
