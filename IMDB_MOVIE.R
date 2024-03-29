library('xml2')
library('rvest')
library('DT')

  url = 'https://www.imdb.com/chart/top?sort=ir,desc&mode=simple&page=1'
pagina = read_html(url)


f.nodes <- html_nodes(pagina, '.titleColumn a')

f.link = sapply(html_attrs(f.nodes), `[[`, 'href')
f.link = paste0("http://www.imdb.com",f.link)
Cast = sapply(html_attrs(f.nodes), `[[`, 'title')
Titulo = html_text(f.nodes)



ano <- html_nodes(pagina, 'a+ .secondaryInfo' )

Year = as.numeric(gsub(")", "",
            gsub("\\(", "",
                 html_text(ano)
                 )))


notas = html_nodes(pagina, '.imdbRating')

votos = as.numeric (gsub(',', '',
                        gsub('user rating',"",
                            gsub('.*?based on ', "",
                                 sapply(html_attrs(notas), `[[`, 'title')
                                 ))))
Rating = as.numeric(html_text(notas))


top <- data.frame(Titulo, Cast, Year, Rating)

cond1 <- subset(top, rateio >= 8.7 & rateio <= 10)
row.names(cond1) <- NULL


DT::datatable(cond1)

