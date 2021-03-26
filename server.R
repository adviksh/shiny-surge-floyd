function(input, output) {
  
  output$stateCounty = renderUI({
    
    state_counties = filter(counties, state_name == input$state)
    
    state_county_names = sort(state_counties$county_name)
    
    selectInput(inputId = "stateCounty", 
                label   = "County:",
                choices = state_county_names)
  })
  
  output$countyMap = renderPlot({
    
    if (length(input$stateCounty) == 0 || input$stateCounty == '') {
      
      ggplot()
      
    } else {
      
      county = filter(counties,
                      state_name  == input$state,
                      county_name == input$stateCounty)
      
      if (nrow(county) != 1) {
        stop('Error: something is wrong internally. ',
             'That choice of state and county identifies multiple rows in ',
             'the county database.')
      }
      
      shp_file = here('shapefiles',
                      glue('tl_2018_{county$state_fp}_bg'),
                      glue('tl_2018_{county$state_fp}_bg.shp'))
      
      shp_state = read_sf(here(shp_file))
      
      # Sorry, merfolk
      shp_state = filter(shp_state, ALAND > 0)
      
      shp_state = transmute(shp_state,
                            state_fp  = STATEFP,
                            county_fp = COUNTYFP,
                            tract_fp  = TRACTCE,
                            geoid     = as.numeric(GEOID),
                            geometry  = geometry)
      
      shp_county = inner_join(shp_state, county,
                              by = c('state_fp', 'county_fp'))
      
      surge_col_name = glue('outside_perc_{input$surgeLookback}wk')
      
      srg_county = inner_join(shp_county, 
                              filter(surge, date == date_to_int(input$date)),
                              by = 'geoid')
      srg_county = mutate(srg_county,
                          surge_bin = cut(srg_county[[surge_col_name]],
                                          breaks  = c(0, 50, 200, 500, 1000, 1500, Inf),
                                          dig.lab = 4))
      
      ggplot(srg_county,
             aes(geometry = geometry)) +
        theme_minimal() +
        theme(panel.grid = element_blank(),
              axis.title = element_blank(),
              axis.text = element_blank(),
              legend.position = 'bottom',
              legend.direction = 'horizontal') +
        scale_fill_viridis_d(name = 'Device Surge\n(Binned)',
                             option    = 'magma', 
                             drop      = FALSE, 
                             direction = -1) +
        geom_sf(aes(fill = surge_bin),
                color = NA)
    }
  })
}
