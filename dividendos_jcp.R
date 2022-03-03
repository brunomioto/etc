# pacotes -----------------------------------------------------------------
library(dplyr)
library(stringr)

# dados -------------------------------------------------------------------

#Acesse https://www.investidor.b3.com.br/
#Menu > Extrato > Posição(Movimentação) > Filtrar
b3 <- read.delim("clipboard", na.strings = " - ")

b3 %>% 
  filter(Movimentação %in% c("Dividendo", "Juros Sobre Capital Próprio", "Rendimento")) %>% 
  mutate(ticket = word(Produto, 1),
         Valor.da.Operação = str_remove_all(Valor.da.Operação, "R\\$"),
         Valor.da.Operação = as.double(str_replace_all(Valor.da.Operação, "\\,", "\\."))) %>% 
  group_by(Movimentação, ticket) %>% 
  summarise(total = "soma")
  
  
