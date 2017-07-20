library(shiny)
#library(DT)
#require(devtools)
#library(rCharts)
shinyServer(function(input, output) {

load(file = "/home/nikolaeva/AgedBrain/ppi2_data/ABSBShinyData.RData") 
load(file ="/home/nikolaeva/absb_bup/results/integration/integrated_int_attributes_web_net.RData")

# Added network customize the length drop-down menu; display 10 rows per page by default
    
output$table9 = renderDataTable({
 net[, input$show_vars_intnet, drop = FALSE]
 },options = list(aLengthMenu = c(10, 30, 50, 100, 250), iDisplayLength = 10))

# Data downloads

#HBTRC
output$downloadDataHBTRC <- downloadHandler(
    filename = "hbtrc_epistatic_interactions.tsv",
    content = function(file) {
      file.copy("/home/nikolaeva/AgedBrain/ppi2_data/epistasis/data_epi/HBTRC_epistatic_gene_pairs_Braak_1e-8.tsv", file) 
	})
#TGEN
output$downloadDataTGEN <- downloadHandler(
    filename = "tgen_epistatic_interactions.tsv",
    content = function(file) {
      file.copy("/home/nikolaeva/AgedBrain/ppi2_data/epistasis/data_epi/TGen_epistatic_gene_pairs_Braak_1e_8.tsv", file)
        })

#ADNI_VER
output$downloadDataADNIVER <- downloadHandler(
    filename = "adni_ventrical_volume_epistatic_interactions.tsv",
    content = function(file) {
      file.copy("/home/nikolaeva/AgedBrain/ppi2_data/epistasis/data_epi/epistatic_bin-bin_interactions_at_MAF_prod_GE_0.01_bonf_pvalue_LE_1.0E-11.tsv", file)
        }) 

#ADNI_COG
output$downloadDataADNICOG <- downloadHandler(
    filename = "adni_cognitive_traits_epistatic_interactions.txt",
    content = function(file) {
      file.copy("/home/nikolaeva/AgedBrain/ppi2_data/epistasis/data_epi/ADNI_cognitive_traits_bin-bin_interactions_07092016.txt", file)
        }) 

#PBA        
output$downloadDataPBA <- downloadHandler(
    filename = "pba.txt",
    content = function(file) {
      file.copy("/home/nikolaeva/absb_bup/results/pba/pba_int.txt", file)
        }) 

#Positive selection        
output$downloadDataPS <- downloadHandler(
    filename = "positive_selection.csv",
    content = function(file) {
      file.copy("/home/nikolaeva/absb_bup/data/ps/positive_selection_data.csv", file)
        }) 

#Intact human
output$downloadDataIAH <- downloadHandler(
    filename = "iah.csv",
    content = function(file) {
      file.copy("/home/nikolaeva/AgedBrain/ppi2_data/intact/intact_hs_v_4_2_6.txt", file)
        })

#Integrated dataset with attributes
output$downloadDataINTDS <- downloadHandler(
    filename = "integrated_int_attributes.txt",
    content = function(file) {
      file.copy("/home/nikolaeva/absb_bup/results/integration/integrated_int_attributes.txt", file)
        })

#Integrated dataset, interactions only
output$downloadDataINT <- downloadHandler(
    filename = "integrated_int_attributes.txt",
    content = function(file) {
      file.copy("/home/nikolaeva/absb_bup/results/integration/integrated_int.txt", file)
        })

#Integrated dataset, gene attributes
output$downloadDataNATTR <- downloadHandler(
    filename = "gene_attributes.txt",
    content = function(file) {
      file.copy("/home/nikolaeva/absb_bup/results/integration/node_attributes.txt.txt", file)
        })



# Added network customize the length drop-down menu; display 10 rows per page by default
    output$help = renderDataTable({
        help
    })
   #web pageopening
   getPage<-function(){
    return((HTML(readLines('http://www.google.com'))))
  }
  output$inc<-renderUI({
   # x <- input$ebi  
    getPage()
  })
datasetInput <- reactive({
    switch(input$dataset,
	   "Integrated data collection" = net
           )
  })


})
