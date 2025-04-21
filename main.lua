LG = love.graphics
LK = love.keyboard

-- Cores
local black = {0, 0, 0, 1}
local white = {1, 1, 1, 1}

-- Variaveis Globais
MenuPrincipal = {posX=0, posY=0, canvas=nil}
BtnDificuldade = {ativado=false, txt="", width=0, height=0}

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

    -- BtnDificuldade
    BtnDificuldade.txt = "Selecione a dificuldade"
    BtnDificuldade.width = Fonte2:getWidth(BtnDificuldade.txt)
    BtnDificuldade.height = Fonte2:getHeight(BtnDificuldade.txt)

    -- Testes
    printx = 0
    printy = 0
    botao = ""
end

function love.draw()
    LG.print("" .. tostring(love.timer.getFPS()), 0,0)
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

    -- Separador
    LG.line(MenuPrincipal.posX+1, MenuPrincipal.posY+230, MenuPrincipal.posX+CanvasX-1, MenuPrincipal.posY+230)

    LG.print("Jogar", MeioX-((Fonte:getWidth("Jogar"))/2), MenuPrincipal.posY+245)
    
    if not BtnDificuldade.ativado then
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
    end

    -- Botão dificuldade | Dropdown
    LG.setFont(Fonte2)
    LG.print(BtnDificuldade.txt, MeioX-BtnDificuldade.width/2-Fonte2:getWidth(" v"), MenuPrincipal.posY+320)
    LG.print(" v", MeioX+BtnDificuldade.width/2, MenuPrincipal.posY+320)
    LG.line(MeioX-BtnDificuldade.width/2-Fonte2:getWidth(" v"), MenuPrincipal.posY+320+BtnDificuldade.height, MeioX+BtnDificuldade.width/2+Fonte2:getWidth(" v"), MenuPrincipal.posY+320+BtnDificuldade.height)
    if BtnDificuldade.ativado then
        LG.setColor(white)
        LG.rectangle("fill", MeioX-BtnDificuldade.width/2, MenuPrincipal.posY+320+BtnDificuldade.height+5, BtnDificuldade.width, BtnDificuldade.height+75)
        LG.setColor(black)

        LG.print("Fácil", MeioX-(Fonte2:getWidth("Fácil")/2), MenuPrincipal.posY+320+BtnDificuldade.height+10)
        LG.line(MeioX-(Fonte2:getWidth("Fácil")/2)-20, MenuPrincipal.posY+320+BtnDificuldade.height+10+Fonte2:getHeight("Fácil")+2.5, MeioX+(Fonte2:getWidth("Fácil")/2)+20, MenuPrincipal.posY+320+BtnDificuldade.height+10+Fonte2:getHeight("Fácil")+2.5)

        LG.print("Médio", MeioX-(Fonte2:getWidth("Médio")/2), MenuPrincipal.posY+320+BtnDificuldade.height+40)
        LG.line(MeioX-(Fonte2:getWidth("Fácil")/2)-20, MenuPrincipal.posY+320+BtnDificuldade.height+40+Fonte2:getHeight("Fácil")+2.5, MeioX+(Fonte2:getWidth("Fácil")/2)+20, MenuPrincipal.posY+320+BtnDificuldade.height+40+Fonte2:getHeight("Fácil")+2.5)

        LG.print("Difícil", MeioX-(Fonte2:getWidth("Difícil")/2), MenuPrincipal.posY+320+BtnDificuldade.height+70)
    end
    -- Testes
    LG.print(botao, printx, printy)
end

function love.update(dt)
    if LK.isDown('escape') then
        love.event.quit()
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then	
        if not BtnDificuldade.ativado then
            if x >= MeioX-BtnDificuldade.width/2-5 and x <= MeioX+BtnDificuldade.width/2+5 and y >= MenuPrincipal.posY+320-5 and y <= MenuPrincipal.posY+320+BtnDificuldade.height+5 then
                BtnDificuldade.ativado = true
            end

            -- Novo Jogo
            if x >= MeioX-125 and x <= MeioX-125+250 and y >= MenuPrincipal.posY+400 and y <= MenuPrincipal.posY+400+65 then
                printx = x
                printy = y
                botao = "Novo Jogo"
            end

            -- Continuar
            if x >= MeioX-125 and x <= MeioX-125+250 and y >= MenuPrincipal.posY+515 and y <= MenuPrincipal.posY+515+65 then
                printx = x
                printy = y
                botao = "Continuar"
            end

            -- Sair
            if x >= MeioX-125 and x <= MeioX-125+250 and y >= MenuPrincipal.posY+630 and y <= MenuPrincipal.posY+630+65 then
                love.event.quit()
            end
        else
            if x >= MeioX-BtnDificuldade.width and x <= MeioX+BtnDificuldade.width and y >= MenuPrincipal.posY+320+BtnDificuldade.height+5 and y <= MenuPrincipal.posY+320+BtnDificuldade.height+100 then
                if x >= MeioX-BtnDificuldade.width and x <= MeioX+BtnDificuldade.width and y >= MenuPrincipal.posY+320+BtnDificuldade.height+10 and y <= MenuPrincipal.posY+320+BtnDificuldade.height+10+Fonte2:getHeight("Fácil") then
                    BtnDificuldade.txt = "Fácil"
                    BtnDificuldade.ativado = false
                end
                if x >= MeioX-BtnDificuldade.width and x <= MeioX+BtnDificuldade.width and y >= MenuPrincipal.posY+320+BtnDificuldade.height+40 and y <= MenuPrincipal.posY+320+BtnDificuldade.height+40+Fonte2:getHeight("Médio") then
                    BtnDificuldade.txt = "Médio"
                    BtnDificuldade.ativado = false
                end
                if x >= MeioX-BtnDificuldade.width and x <= MeioX+BtnDificuldade.width and y >= MenuPrincipal.posY+320+BtnDificuldade.height+70 and y <= MenuPrincipal.posY+320+BtnDificuldade.height+70+Fonte2:getHeight("Difícil")+5 then
                    BtnDificuldade.txt = "Difícil"
                    BtnDificuldade.ativado = false
                end
            else
                if x >= MenuPrincipal.posX and y >= MenuPrincipal.posY then
                    BtnDificuldade.ativado = false
                end
            end
        end
    end
end
