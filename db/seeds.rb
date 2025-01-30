require 'httparty'
require 'dotenv/load' # Carregar as variáveis de ambiente

Dotenv.load('.env')
UNSPLASH_ACCESS_KEY = ENV['UNSPLASH_ACCESS_KEY']
def fetch_image(query)
  encoded_query = URI.encode_www_form_component("#{query} produtos") # Codifica para URL segura
  url = "https://api.unsplash.com/photos/random?query=#{encoded_query}&client_id=#{UNSPLASH_ACCESS_KEY}&w=800&h=600&orientation=landscape"
  
  response = HTTParty.get(url)

  if response.success?
    json = JSON.parse(response.body)
    return json["urls"]["regular"]
  else
    puts "Erro ao buscar imagem para: #{query}"
    return nil
  end
end

products_data = [
  {
    "name": "Smartphone iPhone 14 Pro",
    "description": "O iPhone 14 Pro vem com uma tela Super Retina XDR de 6,1 polegadas e o chip A16 Bionic. Câmera tripla de 48 MP e Face ID para segurança.",
    "price": 7499.99
  },
  {
    "name": "Café Nespresso Vertuo Next",
    "description": "Máquina de café expresso Nespresso com sistema Vertuo. Versátil, com 5 tamanhos de cápsulas e sistema de preparo rápido.",
    "price": 999.99
  },
  {
    "name": "Tênis Nike Air Max 270",
    "description": "Tênis esportivo Nike Air Max 270, com amortecimento de ar visível e design moderno para máxima performance e conforto.",
    "price": 599.99
  },
  {
    "name": "Smart TV Samsung 50\" 4K",
    "description": "TV Samsung 50 polegadas, resolução 4K, com tecnologia QLED, assistente de voz Bixby e compatibilidade com Alexa e Google Assistant.",
    "price": 2899.99
  },
  {
    "name": "Cadeira Gamer DXRacer Racing Series",
    "description": "Cadeira ergonômica para gamers, ajustável, com apoio de braço 3D e design confortável para longas sessões de jogo.",
    "price": 1499.99
  },
  {
    "name": "Fones de Ouvido Sony WH-1000XM4",
    "description": "Fones de ouvido com cancelamento de ruído ativo, som de alta qualidade e 30 horas de autonomia de bateria.",
    "price": 1599.99
  },
  {
    "name": "Notebook Dell Inspiron 15",
    "description": "Notebook Dell Inspiron 15 com processador Intel Core i7, 8GB de RAM e 512GB de SSD. Ideal para trabalho e estudos.",
    "price": 4999.99
  },
  {
    "name": "Relógio Garmin Forerunner 245",
    "description": "Relógio inteligente Garmin Forerunner 245 com GPS integrado, monitoramento de batimentos cardíacos e modos de treino avançados.",
    "price": 2499.99
  },
  {
    "name": "Lâmpada Inteligente Philips Hue",
    "description": "Lâmpada inteligente Philips Hue, compatível com Alexa e Google Assistant, permite controle remoto e personalização de cores.",
    "price": 229.99
  },
  {
    "name": "Micro-ondas LG Smart Inverter",
    "description": "Micro-ondas LG Smart Inverter de 32L, com tecnologia de aquecimento uniforme, 10 níveis de potência e funções automáticas.",
    "price": 999.99
  }
]
CartItem.delete_all
Product.delete_all

products_data.each do |product|
  image_url = fetch_image(product[:name]) # Busca a imagem no Unsplash
  Product.create(product.merge(image: image_url))
end


