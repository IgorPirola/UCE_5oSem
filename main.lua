LG = love.graphics
LK = love.keyboard

-- Cores
local black = {0, 0, 0, 1}
local white = {1, 1, 1, 1}
local red = {1, 0, 0, 1}

-- Variaveis Globais
MenuPrincipal = {posX=0, posY=0, canvas=nil, ativado=true, slcDif=false, canvasX=0, canvasY=0}
BtnDificuldade = {ativado=false, txt="", width=0, height=0}
MenuJogo = {posX=0, posY=0, canvas=nil, ativado=false, canvasX=0, canvasY=0}

function love.load()
    Fonte = LG.newFont('src/Inter-VariableFont_opsz,wght.ttf', 22)
    Fonte2 = LG.newFont('src/Inter-VariableFont_opsz,wght.ttf', 18)
    MeioX = (LG.getWidth() / 2)
    MeioY = (LG.getHeight() / 2)
    NumPergunta = 1

    -- Definições do Menu Principal
    MenuPrincipal.canvasX = 380
    MenuPrincipal.canvasY = 800

    MenuPrincipal.posX = MeioX - (MenuPrincipal.canvasX / 2)
    MenuPrincipal.posY = MeioY - (MenuPrincipal.canvasY / 2)

    MenuPrincipal.canvas = LG.newCanvas(MenuPrincipal.canvasX, MenuPrincipal.canvasY)

    LG.setCanvas(MenuPrincipal.canvas)
        LG.clear(white)
        LG.setBlendMode("alpha")
    LG.setCanvas()

    -- BtnDificuldade
    BtnDificuldade.txt = "Selecione a dificuldade"
    BtnDificuldade.width = Fonte2:getWidth(BtnDificuldade.txt)
    BtnDificuldade.height = Fonte2:getHeight(BtnDificuldade.txt)

    -- Definições do Menu do Jogo
    MenuJogo.canvasX = 380
    MenuJogo.canvasY = 700

    MenuJogo.posX = MeioX - (MenuJogo.canvasX / 2)
    MenuJogo.posY = MeioY - (MenuJogo.canvasY / 2)

    MenuJogo.canvas = LG.newCanvas(MenuJogo.canvasX, MenuJogo.canvasY)

    LG.setCanvas(MenuJogo.canvas)
        LG.clear(white)
        LG.setBlendMode("alpha")
    LG.setCanvas()

    -- Testes
    printx = 0
    printy = 0
    botao = ""

    -- Ilength = 0
	-- local file = assert(io.open("src/perguntas.txt", "r"))
	-- items = {}
	-- for line in file:lines() do
	-- 	Ilength = Ilength + 1
	-- 	table.insert(items, line);
	-- end
end

function love.draw()
    LG.setColor(black)
    LG.print("" .. tostring(love.timer.getFPS()), 0,0)
    LG.setBackgroundColor(white)

    if MenuJogo.ativado then
        -- Desenhando os elementos do menu do jogo
        LG.setColor(.5176, .3646, .4824, 1) -- Cor do menu
        LG.draw(MenuJogo.canvas, MenuJogo.posX, MenuJogo.posY-15)

        LG.setColor(black)
        LG.setFont(Fonte)
        local titulo = "Pergunta " .. tostring(NumPergunta)
        LG.print(titulo, MeioX-(Fonte:getWidth(titulo)/2), MenuJogo.posY)

        -- Bloco da pergunta/imagem
        LG.setColor(.7451, .7451, .7451, 1) -- Cinza claro
        LG.rectangle("fill", MeioX-160, MenuJogo.posY+Fonte:getHeight(titulo)+15, 320, 450)

        -- Bloco das respostas
        LG.setColor(.6510, .6392, .6392, 1) -- Cinza mais escuro
        LG.rectangle("fill", MeioX-160, MenuJogo.posY+Fonte:getHeight(titulo)+15+480, 150, 50) -- topo esq
        LG.rectangle("fill", MeioX+10, MenuJogo.posY+Fonte:getHeight(titulo)+15+480, 150, 50) -- topo dir
        LG.rectangle("fill", MeioX-160, MenuJogo.posY+Fonte:getHeight(titulo)+15+480+50+20, 150, 50) --baixo esq
        LG.rectangle("fill", MeioX+10, MenuJogo.posY+Fonte:getHeight(titulo)+15+480+50+20, 150, 50) -- baixo dir
    end

    if MenuPrincipal.ativado then
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
        LG.line(MenuPrincipal.posX+1, MenuPrincipal.posY+230, MenuPrincipal.posX+MenuPrincipal.canvasX-1, MenuPrincipal.posY+230)
    
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
    
        -- Exibe a mensagem para selecionar uma dificuldade
        if MenuPrincipal.slcDif then
            LG.setColor(red)
            LG.print("Selecione uma dificuldade", MeioX-((Fonte:getWidth("Selecione uma dificuldade"))/2), MenuPrincipal.posY+360)
        end

        -- Botão dificuldade | Dropdown
        LG.setColor(black)
        LG.setFont(Fonte2)
        LG.print(BtnDificuldade.txt, MeioX-BtnDificuldade.width/2-Fonte2:getWidth(" v"), MenuPrincipal.posY+320)
        LG.print(" v", MeioX+BtnDificuldade.width/2, MenuPrincipal.posY+320)
        LG.line(MeioX-BtnDificuldade.width/2-Fonte2:getWidth(" v"), MenuPrincipal.posY+320+BtnDificuldade.height, MeioX+BtnDificuldade.width/2+Fonte2:getWidth(" v"), MenuPrincipal.posY+320+BtnDificuldade.height)
        if BtnDificuldade.ativado then
            LG.setColor(white)
            LG.rectangle("fill", MeioX-BtnDificuldade.width/2, MenuPrincipal.posY+320+BtnDificuldade.height+5, BtnDificuldade.width, BtnDificuldade.height+95)
            LG.setColor(black)
    
            LG.print("Fácil", MeioX-(Fonte2:getWidth("Fácil")/2), MenuPrincipal.posY+320+BtnDificuldade.height+15)
            LG.line(MeioX-(Fonte2:getWidth("Fácil")/2)-20, MenuPrincipal.posY+320+BtnDificuldade.height+20+Fonte2:getHeight("Fácil")+2.5, MeioX+(Fonte2:getWidth("Fácil")/2)+20, MenuPrincipal.posY+320+BtnDificuldade.height+20+Fonte2:getHeight("Fácil")+2.5)
    
            LG.print("Médio", MeioX-(Fonte2:getWidth("Médio")/2), MenuPrincipal.posY+320+BtnDificuldade.height+50)
            LG.line(MeioX-(Fonte2:getWidth("Fácil")/2)-20, MenuPrincipal.posY+320+BtnDificuldade.height+55+Fonte2:getHeight("Fácil")+2.5, MeioX+(Fonte2:getWidth("Fácil")/2)+20, MenuPrincipal.posY+320+BtnDificuldade.height+55+Fonte2:getHeight("Fácil")+2.5)
    
            LG.print("Difícil", MeioX-(Fonte2:getWidth("Difícil")/2), MenuPrincipal.posY+320+BtnDificuldade.height+85)
        end
    end
    
    -- Testes
    LG.setColor(black)
    LG.print(botao, printx, printy)
end

function love.update(dt)
    if not MenuPrincipal.ativado and not MenuJogo.ativado then
        MenuPrincipal.ativado = true
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then	
        if MenuJogo.ativado then
            -- Respostas
            local titulo = "Pergunta " .. tostring(NumPergunta)

            -- Resp 1
            if x >= MeioX-160 and x <= MeioX-10 and y >= MenuJogo.posY+Fonte:getHeight(titulo)+15+480 and y <= MenuJogo.posY+Fonte:getHeight(titulo)+15+480+50 then
                NumPergunta = NumPergunta + 1
            end

            -- Resp 2
            if x >= MeioX+10 and x <= MeioX+160 and y >= MenuJogo.posY+Fonte:getHeight(titulo)+15+480 and y <= MenuJogo.posY+Fonte:getHeight(titulo)+15+480+50 then
                NumPergunta = NumPergunta + 1
            end

            -- Resp 3
            if x >= MeioX-160 and x <= MeioX-10 and y >= MenuJogo.posY+Fonte:getHeight(titulo)+15+480+50+20 and y <= MenuJogo.posY+Fonte:getHeight(titulo)+15+480+50+20+50 then
                NumPergunta = NumPergunta + 1
            end

            -- Resp 4
            if x >= MeioX+10 and x <= MeioX+160 and y >= MenuJogo.posY+Fonte:getHeight(titulo)+15+480+50+20 and y <= MenuJogo.posY+Fonte:getHeight(titulo)+15+480+50+20+50 then
                NumPergunta = NumPergunta + 1
            end
        end
        if MenuPrincipal.ativado then
            if not BtnDificuldade.ativado then
                if x >= MeioX-BtnDificuldade.width/2-5 and x <= MeioX+BtnDificuldade.width/2+5 and y >= MenuPrincipal.posY+320-5 and y <= MenuPrincipal.posY+320+BtnDificuldade.height+5 then
                    BtnDificuldade.ativado = true
                end

                -- Novo Jogo
                if x >= MeioX-125 and x <= MeioX-125+250 and y >= MenuPrincipal.posY+400 and y <= MenuPrincipal.posY+400+65 then
                    if BtnDificuldade.txt ~= "Selecione a dificuldade" then
                        MenuPrincipal.ativado = false
                        MenuJogo.ativado = true
                    else
                        MenuPrincipal.slcDif = true
                    end
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
                    if x >= MeioX-BtnDificuldade.width and x <= MeioX+BtnDificuldade.width and y >= MenuPrincipal.posY+320+BtnDificuldade.height+10 and y <= MenuPrincipal.posY+320+BtnDificuldade.height+10+Fonte2:getHeight("Fácil")+10 then
                        BtnDificuldade.txt = "Fácil"
                        BtnDificuldade.ativado = false
                        MenuPrincipal.slcDif = false
                    end
                    if x >= MeioX-BtnDificuldade.width and x <= MeioX+BtnDificuldade.width and y >= MenuPrincipal.posY+320+BtnDificuldade.height+45 and y <= MenuPrincipal.posY+320+BtnDificuldade.height+54+Fonte2:getHeight("Médio") then
                        BtnDificuldade.txt = "Médio"
                        BtnDificuldade.ativado = false
                        MenuPrincipal.slcDif = false
                    end
                    if x >= MeioX-BtnDificuldade.width and x <= MeioX+BtnDificuldade.width and y >= MenuPrincipal.posY+320+BtnDificuldade.height+80 and y <= MenuPrincipal.posY+320+BtnDificuldade.height+80+Fonte2:getHeight("Difícil")+5 then
                        BtnDificuldade.txt = "Difícil"
                        BtnDificuldade.ativado = false
                        MenuPrincipal.slcDif = false
                    end
                else
                    if x >= MenuPrincipal.posX and y >= MenuPrincipal.posY then
                        BtnDificuldade.ativado = false
                    end
                end
            end
        end
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'escape' then
        if MenuPrincipal.ativado then
            love.event.quit()
        end 
        if MenuJogo.ativado then
            MenuJogo.ativado = false
            MenuPrincipal.ativado = true
        end
    end
end
