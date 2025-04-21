LG = love.graphics

local black = {0, 0, 0, 1}
local white = {1, 1, 1, 1}
MenuPrincipal = {posX=0, posY=0, canvas=nil}

function love.load()
    Fonte = LG.newFont('src/Inter-VariableFont_opsz,wght.ttf', 22)
    Fonte2 = LG.newFont('src/Inter-VariableFont_opsz,wght.ttf', 18)
    MeioX = (LG.getWidth() / 2)
    MeioY = (LG.getHeight() / 2)

    -- Definições do Menu Principal
    CanvasX = 380
    CanvasY = 800

    MenuPrincipal.posX = MeioX - (CanvasX / 2)
    MenuPrincipal.posY = MeioY - (CanvasY / 2)

    MenuPrincipal.canvas = LG.newCanvas(CanvasX, CanvasY)

    LG.setCanvas(MenuPrincipal.canvas)
        LG.clear(white)
        LG.setBlendMode("alpha")
    LG.setCanvas()

    -- Testes
    printx = 0
    printy = 0
end

function love.draw()
    LG.setBackgroundColor(white)
    LG.setFont(Fonte)

    -- Desenhando os elementos do menu principal
    LG.setColor(.5176, .3646, .4824, 1) -- Cor do menu
    LG.draw(MenuPrincipal.canvas, MenuPrincipal.posX, MenuPrincipal.posY-10)

    -- Textos
    LG.setColor(black) 
    LG.print("Estatisticas", MeioX-((Fonte:getWidth("Estatisticas"))/2), MenuPrincipal.posY)
    LG.print("Partidas Jogadas: ", MenuPrincipal.posX+15, MenuPrincipal.posY+70)
    LG.print("Acertos: ", MenuPrincipal.posX+15, MenuPrincipal.posY+110)
    LG.print("Erros: ", MenuPrincipal.posX+15, MenuPrincipal.posY+150)
    LG.line(MenuPrincipal.posX+1, MenuPrincipal.posY+230, MenuPrincipal.posX+CanvasX-1, MenuPrincipal.posY+230)
    LG.print("Jogar", MeioX-((Fonte:getWidth("Jogar"))/2), MenuPrincipal.posY+245)

    LG.setFont(Fonte2)
    LG.print("Selecione a dificuldade", MeioX-((Fonte2:getWidth("Selecione a dificuldade"))/2), MenuPrincipal.posY+320)
    
    -- Botões
    LG.setColor(white)
    LG.rectangle("fill", MeioX-125,MenuPrincipal.posY+400, 250, 65)
    LG.rectangle("fill", MeioX-125,MenuPrincipal.posY+515, 250, 65)
    LG.rectangle("fill", MeioX-125,MenuPrincipal.posY+630, 250, 65)

    -- Texto dos botões
    LG.setFont(Fonte)
    LG.setColor(black)
    LG.print("Novo Jogo", MeioX-((Fonte:getWidth("Novo Jogo"))/2), MenuPrincipal.posY+400+32.5-((Fonte:getHeight("Novo Jogo"))/2))
    LG.print("Continuar", MeioX-((Fonte:getWidth("Continuar"))/2), MenuPrincipal.posY+515+32.5-((Fonte:getHeight("Continuar"))/2))
    LG.print("Sair", MeioX-((Fonte:getWidth("Sair"))/2), MenuPrincipal.posY+630+32.5-((Fonte:getHeight("Sair"))/2))
    
    -- Testes
    love.graphics.print("Click", printx, printy)
end

function love.update(dt)
    
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then	
        if x >= MeioX-125 and x <= MeioX-125+250 and y >= MenuPrincipal.posY+400 and y <= MenuPrincipal.posY+400+65 then
            printx = x
            printy = y
        end
        if x >= MeioX-125 and x <= MeioX-125+250 and y >= MenuPrincipal.posY+515 and y <= MenuPrincipal.posY+515+65 then
            printx = x
            printy = y
        end
        if x >= MeioX-125 and x <= MeioX-125+250 and y >= MenuPrincipal.posY+630 and y <= MenuPrincipal.posY+630+65 then
            love.event.quit()
        end
    end
  end