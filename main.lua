Perguntas = require("perguntas")

LG = love.graphics
LK = love.keyboard

-- Cores
local black = {0, 0, 0, 1}
local white = {1, 1, 1, 1}
local red = {1, 0, 0, 1}
local green = {0, .4, 0, 1}
local gray = {.7,.7,.7,.9}

MenuPrincipal = {posX=0, posY=0, img=nil, ativado=true}
MenuJogo = {posX=0, posY=0, img=nil, tr=nil, ativado=false, trAtivado=false, tmp=0}
MenuVitoria = {posX=0, posY=0, img=nil, ativado=false}
MenuInst = {posX=0, posY=0, img=nil, ativado=false}
MenuErr = {posX=0, posY=0, img=nil, ativado=false}

Botoes = {
    Jogar = {posX=0, posY=0, img=nil, color=red, selected=false},
    Instrucao = {posX=0, posY=0, img=nil, color=red, selected=false},
    R1 = {posX=0, posY=0, img=nil, color=white, selected=false},
    R2 = {posX=0, posY=0, img=nil, color=white, selected=false},
    R3 = {posX=0, posY=0, img=nil, color=white, selected=false},
    R4 = {posX=0, posY=0, img=nil, color=white, selected=false},
    Erros = {posX=0, posY=0, img=nil, color=white, selected=false},
    Prox = {posX=0, posY=0, img=nil, color=white, selected=false},
    Voltar = {posX=0, posY=0, img=nil, color=white, selected=false},
}
Comp = {
    Clock = {posX=0, posY=0, img=nil, color=green},
    ClockNum = {posX=0, posY=0, text="", seg=0},
    pontuacao = {posX=0, posY=0},
    tempoResposta = {posX=0, posY=0},
    confete = {posX=0, posY=0, img=nil, ativado=false}
}
pontuacao = 0
tempoResposta = 0
imagemPerg = {
    p1=nil
}
indexProx = 1

margem = 40

function love.load()
    MeioX = LG.getWidth() / 2
    MeioY = LG.getHeight() / 2

    fonte48 = LG.newFont(48)
    fonte48n = LG.newFont("src/Inter_18pt-Black.ttf", 48)
    fonte32 = LG.newFont(32)

    btnVoltar = Botoes.Voltar
    btnVoltar.img = LG.newImage("src/btnVoltar.png")
    btnVoltar.posX = 990
    btnVoltar.posY = 24

    loadMenuPrinc()
    loadMenuJogo()
    loadMenuVitoria()
    loadMenuInst()
    loadMenuErr()

    -- testes
end

function love.draw()
    if MenuPrincipal.ativado then
        drawMenuPrinc()
    elseif MenuJogo.ativado then
        drawMenuJogo()
    elseif MenuVitoria.ativado then
        drawMenuVitoria()
    elseif MenuInst.ativado then
        drawMenuInst()
    elseif MenuErr.ativado then
        drawMenuErr()
    end
end

function love.update(dt)
    if MenuJogo.ativado then
        atualizarClock(dt)
        for i, pergunta in ipairs(Perguntas.lista) do
            pergunta.ativo = (Perguntas.index == i)
        end
        if MenuJogo.trAtivado then
            MenuJogo.tmp = MenuJogo.tmp + dt
            MenuJogo.trAtivado = MenuJogo.tmp < .7
        else
            MenuJogo.tmp = 0
        end
        tempoResposta = tempoResposta + dt
    elseif MenuErr.ativado then 
        for i, pergunta in ipairs(Perguntas.lista) do
            if (Perguntas.index == i) and (pergunta.selec ~= 0) and (pergunta.selec ~= pergunta.resp) then
                pergunta.ativo = true
                break
            else
                pergunta.ativo = false
            end
        end
        if Perguntas.index > #Perguntas.lista then
            tempoResposta = 0
            pontuacao = 0
            Perguntas.index = 0
            trocarPergunta()
            ativaMenuPrinc()
        end
    end
end

function love.mousemoved(x, y)
    if MenuPrincipal.ativado then
        mousemovedMenuPrinc(x, y)
    elseif MenuJogo.ativado then
        mousemovedMenuJogo(x, y)
    elseif MenuVitoria.ativado then
        mousemovedMenuVitoria(x, y)
    elseif MenuErr.ativado then
        mousemovedMenuErr(x, y)
    elseif MenuInst.ativado then
        if x >= btnVoltar.posX and x <= btnVoltar.posX+btnVoltar.img:getWidth() and y >= btnVoltar.posY and y <= btnVoltar.posY+btnVoltar.img:getHeight() then
            btnVoltar.selected = true
            btnVoltar.color = gray
        else
            btnVoltar.selected = false
            btnVoltar.color = white
        end
    end
end

function love.mousepressed(x, y) 
    if MenuPrincipal.ativado then
        mousepressedMenuPrinc(x, y)
    elseif MenuJogo.ativado and not MenuJogo.trAtivado then
        mousepressedMenuJogo(x, y)
    elseif MenuVitoria.ativado then
        mousepressedMenuVitoria(x, y)
    elseif MenuErr.ativado then
        mousepressedMenuErr(x, y)
    elseif MenuInst.ativado then
        if btnVoltar.selected then
            ativaMenuPrinc()
        end
    end
end

function love.keypressed(key)
    if MenuJogo.ativado and not MenuJogo.trAtivado then
        keypressedMenuJogo(key)
    elseif MenuInst.ativado or MenuVitoria.ativado then
        keypressedMenuOp(key)
    elseif MenuErr.ativado then
        keypressedMenuErr(key)
    end
end

function ativaMenuPrinc()
    MenuPrincipal.ativado = true
    MenuJogo.ativado = false
    MenuVitoria.ativado = false
    MenuInst.ativado = false
end

function ativaMenuJogo()
    MenuPrincipal.ativado = false
    MenuJogo.ativado = true
    MenuVitoria.ativado = false
    MenuInst.ativado = false
    MenuErr.ativado = false
end

function ativaMenuVitoria()
    MenuPrincipal.ativado = false
    MenuJogo.ativado = false
    MenuVitoria.ativado = true
    MenuInst.ativado = false
    MenuErr.ativado = false
end

function ativaMenuInst()
    MenuPrincipal.ativado = false
    MenuJogo.ativado = false
    MenuVitoria.ativado = false
    MenuInst.ativado = true
    MenuErr.ativado = false
end

function ativaMenuErr()
    Perguntas.index = 1
    while Perguntas.index <= #Perguntas.lista and Perguntas.lista[Perguntas.index].selec ~= 0 and Perguntas.lista[Perguntas.index].selec == Perguntas.lista[Perguntas.index].resp do
        Perguntas.index = Perguntas.index + 1
    end
    MenuPrincipal.ativado = false
    MenuJogo.ativado = false
    MenuVitoria.ativado = false
    MenuInst.ativado = false
    MenuErr.ativado = true
end

function loadMenuPrinc()
    MenuPrincipal.img = LG.newImage("src/MenuPrincFundo.png")
    MenuPrincipal.img:setFilter("nearest", "nearest") 

    MenuPrincipal.posX = MeioX - MenuPrincipal.img:getWidth() / 2
    MenuPrincipal.posY = MeioY - MenuPrincipal.img:getHeight() / 2

    btnInst = Botoes.Instrucao
    btnInst.img = LG.newImage("src/btnInstrucao.png")
    btnInst.posX = MeioX - btnInst.img:getWidth() / 2
    btnInst.posY = MeioY + btnInst.img:getHeight() - margem

    btnJogar = Botoes.Jogar
    btnJogar.img = LG.newImage("src/btnJogar.png")
    btnJogar.posX = MeioX - btnJogar.img:getWidth() / 2
    btnJogar.posY = MeioY + btnJogar.img:getHeight() + margem * 2
end

function loadMenuJogo()
    MenuJogo.img = LG.newImage("src/MenuJogoFundo.png")
    MenuJogo.tr = LG.newImage("src/MenuJogoFundo2.png")

    MenuJogo.posX = MeioX - MenuJogo.img:getWidth() / 2
    MenuJogo.posY = MeioY - MenuJogo.img:getHeight() / 2
    Clock = Comp.Clock

    Clock.img = LG.newImage("src/clock.png")
    Clock.posX = 50
    Clock.posY = 20

    ClockNum = Comp.ClockNum
    ClockNum.posX = 110
    ClockNum.posY = 20
    ClockNum.seg = Perguntas.lista[1].temp
    ClockNum.text = "00:" .. ClockNum.seg

    Perguntas.posX = 60
    Perguntas.posY = 100

    btnR1 = Botoes.R1
    btnR2 = Botoes.R2
    btnR3 = Botoes.R3
    btnR4 = Botoes.R4

    btnR1.img = LG.newImage("src/btnRA.png")
    btnR2.img = LG.newImage("src/btnRB.png")
    btnR3.img = LG.newImage("src/btnRC.png")
    btnR4.img = LG.newImage("src/btnRD.png")

    btnR1.posX = 90
    btnR1.posY = 680

    btnR2.posX = 710
    btnR2.posY = 680

    btnR3.posX = 90
    btnR3.posY = 790

    btnR4.posX = 710
    btnR4.posY = 790
end

function loadMenuVitoria()
    MenuVitoria.img = LG.newImage("src/MenuVitoriaFundo.png")
    MenuVitoria.posX = MeioX - MenuVitoria.img:getWidth() / 2
    MenuVitoria.posY = MeioY - MenuVitoria.img:getHeight() / 2

    btnErr = Botoes.Erros
    btnErr.img = LG.newImage("src/btnErros.png")
    btnErr.posX = 167
    btnErr.posY = 772
end

function loadMenuErr()
    MenuErr.img = LG.newImage("src/MenuErrFundo.png")
    MenuErr.posX = MenuJogo.posX
    MenuErr.posY = MenuJogo.posY

    btnProx = Botoes.Prox
    btnProx.img = LG.newImage("src/btnProx.png")
    btnProx.posX = 400
    btnProx.posY = 745
end

function loadMenuInst()
    MenuInst.img = LG.newImage("src/MenuInstFundo.png")
    MenuInst.posX = MeioX - MenuInst.img:getWidth() / 2
    MenuInst.posY = MeioY - MenuInst.img:getHeight() / 2
end

function drawMenuPrinc()
    LG.setColor(white)
    --LG.print("" .. tostring(love.timer.getFPS()), 0,0)
    LG.draw(MenuPrincipal.img, MenuPrincipal.posX, MenuPrincipal.posY)

    LG.setColor(btnInst.color)
    LG.draw(btnInst.img, btnInst.posX, btnInst.posY)

    LG.setColor(btnJogar.color)
    LG.draw(btnJogar.img, btnJogar.posX, btnJogar.posY)
end

function drawMenuJogo()
    if not MenuJogo.trAtivado then
        LG.setColor(white)
        LG.draw(MenuJogo.img, MenuJogo.posX, MenuJogo.posY)
    else
        LG.setColor(white)
        LG.draw(MenuJogo.tr, MenuJogo.posX, MenuJogo.posY)
    end

    LG.setColor(btnVoltar.color)
    LG.draw(btnVoltar.img, btnVoltar.posX, btnVoltar.posY)

    LG.setColor(white)

    LG.draw(Clock.img, Clock.posX, Clock.posY)

    LG.setFont(fonte48)

    LG.setColor(Clock.color)
    LG.print(ClockNum.text, ClockNum.posX, ClockNum.posY)

    LG.setColor(black)

    LG.setFont(fonte32)
    if not MenuJogo.trAtivado then 
        for i, pergunta in ipairs(Perguntas.lista) do
            if pergunta.ativo then
                LG.printf(pergunta.text, Perguntas.posX, Perguntas.posY, 1090)
                break
            end
        end
    end
    
    LG.setColor(btnR1.color)
    LG.draw(btnR1.img, btnR1.posX, btnR1.posY)

    LG.setColor(btnR2.color)
    LG.draw(btnR2.img, btnR2.posX, btnR2.posY)

    LG.setColor(btnR3.color)
    LG.draw(btnR3.img, btnR3.posX, btnR3.posY)

    LG.setColor(btnR4.color)
    LG.draw(btnR4.img, btnR4.posX, btnR4.posY)
end

function drawMenuVitoria()
    LG.setColor(white)
    LG.draw(MenuVitoria.img, MenuVitoria.posX, MenuVitoria.posY)

    LG.setColor(btnVoltar.color)
    LG.draw(btnVoltar.img, btnVoltar.posX, btnVoltar.posY)

    LG.setFont(fonte48n)
    LG.setColor(black)
    LG.print(pontuacao, Comp.pontuacao.posX, Comp.pontuacao.posY)

    local segundos = math.floor(tempoResposta)
    

    if segundos < 60 then
        LG.print(segundos .. "s", Comp.tempoResposta.posX, Comp.tempoResposta.posY)
    else
        local minutos = math.floor(segundos / 60)
        local restoSegundos = segundos % 60
        LG.print(string.format("%dm %ds", minutos, restoSegundos), Comp.tempoResposta.posX, Comp.tempoResposta.posY)
    end

    LG.setColor(btnErr.color)
    LG.draw(btnErr.img, btnErr.posX, btnErr.posY)
end

function drawMenuErr()
    LG.setColor(white)
    LG.draw(MenuErr.img, MenuErr.posX, MenuErr.posY)

    LG.setColor(btnProx.color)
    LG.draw(btnProx.img, btnProx.posX, btnProx.posY)

    LG.setFont(fonte32)
    LG.setColor(black)
    for i, pergunta in ipairs(Perguntas.lista) do
        if pergunta.ativo then
            LG.printf(pergunta.text, Perguntas.posX, Perguntas.posY, 1090)
            LG.setColor(green)
            LG.printf(pergunta.respTxt, Perguntas.posX, 610, 1090)
            break
        end
    end
end

function drawMenuInst()
    LG.setColor(white)
    LG.draw(MenuInst.img, MenuInst.posX, MenuInst.posY)
    
    LG.setColor(btnVoltar.color)
    LG.draw(btnVoltar.img, btnVoltar.posX, btnVoltar.posY)
end

function atualizarClock(dt)
    if ClockNum.seg > 0 then
        ClockNum.seg = ClockNum.seg - 1 * dt
        if ClockNum.seg < 6 then
            Clock.color = red
        elseif ClockNum.seg < (Perguntas.lista[Perguntas.index].temp - 11) then
            Clock.color = black
        end
        if ClockNum.seg < 0 and Perguntas.index < #Perguntas.lista then
            transicao()
            trocarPergunta()
        end
    end
    ClockNum.text = "00:" .. string.format("%02d", math.floor(ClockNum.seg))
end

function mousemovedMenuPrinc(x, y)
    if x >= btnJogar.posX and x <= btnJogar.posX+btnJogar.img:getWidth() and y >= btnJogar.posY and y <= btnJogar.posY+btnJogar.img:getHeight() then
        btnJogar.selected = true
        btnJogar.color = white
    elseif x >= btnInst.posX and x <= btnInst.posX+btnInst.img:getWidth() and y >= btnInst.posY and y <= btnInst.posY+btnInst.img:getHeight() then
        btnInst.selected = true
        btnInst.color = white
    else
        btnJogar.selected = false
        btnInst.selected = false
        btnJogar.color = red
        btnInst.color = red
    end
end

function mousemovedMenuJogo(x, y)
    if x >= btnR1.posX and x <= btnR1.posX+btnR1.img:getWidth() and y >= btnR1.posY and y <= btnR1.posY+btnR1.img:getHeight() then
        btnR1.selected = true
        btnR1.color = gray
    elseif x >= btnR2.posX and x <= btnR2.posX+btnR2.img:getWidth() and y >= btnR2.posY and y <= btnR2.posY+btnR2.img:getHeight() then
        btnR2.selected = true
        btnR2.color = gray
    elseif x >= btnR3.posX and x <= btnR3.posX+btnR3.img:getWidth() and y >= btnR3.posY and y <= btnR3.posY+btnR3.img:getHeight() then
        btnR3.selected = true
        btnR3.color = gray
    elseif x >= btnR4.posX and x <= btnR4.posX+btnR4.img:getWidth() and y >= btnR4.posY and y <= btnR4.posY+btnR4.img:getHeight() then
        btnR4.selected = true
        btnR4.color = gray
    elseif x >= btnVoltar.posX and x <= btnVoltar.posX+btnVoltar.img:getWidth() and y >= btnVoltar.posY and y <= btnVoltar.posY+btnVoltar.img:getHeight() then
        btnVoltar.selected = true
        btnVoltar.color = gray
    else
        btnR1.selected = false
        btnR2.selected = false
        btnR3.selected = false
        btnR4.selected = false
        btnVoltar.selected = false
        btnVoltar.color = white
        btnR4.color = white
        btnR3.color = white
        btnR2.color = white
        btnR1.color = white
    end
end

function mousemovedMenuVitoria(x, y)
    if x >= btnErr.posX and x <= btnErr.posX+btnErr.img:getWidth() and y >= btnErr.posY and y <= btnErr.posY+btnErr.img:getHeight() then
        btnErr.selected = true
        btnErr.color = gray
    elseif x >= btnVoltar.posX and x <= btnVoltar.posX+btnVoltar.img:getWidth() and y >= btnVoltar.posY and y <= btnVoltar.posY+btnVoltar.img:getHeight() then
        btnVoltar.selected = true
        btnVoltar.color = gray
    else
        btnErr.selected = false
        btnErr.color = white
    end
end

function mousemovedMenuErr(x, y)
    if x >= btnProx.posX and x <= btnProx.posX+btnProx.img:getWidth() and y >= btnProx.posY and y <= btnProx.posY+btnProx.img:getHeight() then
        btnProx.selected = true
        btnProx.color = gray
    else
        btnProx.selected = false
        btnProx.color = white
    end
end


function mousepressedMenuPrinc()
    if btnInst.selected then
        ativaMenuInst()
    elseif btnJogar.selected then
        ativaMenuJogo()
    end
end

function mousepressedMenuJogo()
    for i, pergunta in ipairs(Perguntas.lista) do
        if pergunta.ativo then
            if btnR1.selected then
                pergunta.selec = 1
                transicao()
                pontuar(pergunta.resp == 1)
                trocarPergunta()
            elseif btnR2.selected then
                pergunta.selec = 2
                transicao()
                pontuar(pergunta.resp == 2) 
                trocarPergunta() 
            elseif btnR3.selected then
                pergunta.selec = 3
                transicao()
                pontuar(pergunta.resp == 3)
                trocarPergunta()
            elseif btnR4.selected then 
                pergunta.selec = 4
                transicao()
                pontuar(pergunta.resp == 4)   
                trocarPergunta()
            elseif btnVoltar.selected then
                ativaMenuPrinc()
            end  
        end
    end
end

function mousepressedMenuVitoria(x, y)
    if btnErr.selected then
        ativaMenuErr()
    elseif btnVoltar.selected then
        tempoResposta = 0
        pontuacao = 0
        Perguntas.index = 0
        trocarPergunta()
        ativaMenuPrinc()
    end
end

function mousepressedMenuErr(x, y)
    if btnProx.selected then
        if Perguntas.index <= #Perguntas.lista then
            Perguntas.index = Perguntas.index + 1
            while Perguntas.index <= #Perguntas.lista and Perguntas.lista[Perguntas.index].selec ~= 0 and Perguntas.lista[Perguntas.index].selec == Perguntas.lista[Perguntas.index].resp do
                Perguntas.index = Perguntas.index + 1
                if Perguntas.index >= #Perguntas.lista then
                    tempoResposta = 0
                    pontuacao = 0
                    Perguntas.index = 0
                    trocarPergunta()
                    ativaMenuPrinc()
                end
            end
        elseif Perguntas.index >= #Perguntas.lista then
            tempoResposta = 0
            pontuacao = 0
            Perguntas.index = 0
            trocarPergunta()
            ativaMenuPrinc()
        end
    end
end

function keypressedMenuJogo(key)
    if key == 'escape' then
        ativaMenuPrinc()
    end
    for i, pergunta in ipairs(Perguntas.lista) do
        if pergunta.ativo then
            if key == '1' or key == 'kp1' or key == 'a' then
                pergunta.selec = 1
                transicao()
                pontuar(pergunta.resp == 1)
                trocarPergunta()
            elseif key == '2' or key == 'kp2' or key == 'b' then
                pergunta.selec = 2
                transicao()
                pontuar(pergunta.resp == 2) 
                trocarPergunta() 
            elseif key == '3' or key == 'kp3' or key == 'c' then
                pergunta.selec = 3
                transicao()
                pontuar(pergunta.resp == 3)
                trocarPergunta()
            elseif key == '4' or key == 'kp4' or key == 'd' then 
                pergunta.selec = 4
                transicao()
                pontuar(pergunta.resp == 4)   
                trocarPergunta()
            end  
        end
    end
end

function keypressedMenuOp(key)
    if key == 'escape' then
        if MenuVitoria.ativado then
            tempoResposta = 0
            pontuacao = 0
            Perguntas.index = 0
            trocarPergunta()
        end
        ativaMenuPrinc()
    end
end

function keypressedMenuErr(key)
    if key == 'return' or key == 'kpenter' then
        if Perguntas.index <= #Perguntas.lista then
            Perguntas.index = Perguntas.index + 1
            while Perguntas.index <= #Perguntas.lista and Perguntas.lista[Perguntas.index].selec ~= 0 and Perguntas.lista[Perguntas.index].selec == Perguntas.lista[Perguntas.index].resp do
                Perguntas.index = Perguntas.index + 1
                if Perguntas.index >= #Perguntas.lista then
                    tempoResposta = 0
                    pontuacao = 0
                    Perguntas.index = 0
                    trocarPergunta()
                    ativaMenuPrinc()
                end
            end
        elseif Perguntas.index >= #Perguntas.lista then
            tempoResposta = 0
            pontuacao = 0
            Perguntas.index = 0
            trocarPergunta()
            ativaMenuPrinc()
        end
    end
end

function pontuar(validador)
    if validador then
        for i, pergunta in ipairs(Perguntas.lista) do
            if pergunta.ativo then
                local tempoRestante = math.max(ClockNum.seg, 0)
                local tempoLimite = pergunta.temp - 11
                local pontosPorSegundo = 100 / pergunta.temp
                local pontos = tempoRestante * pontosPorSegundo
                if tempoRestante >= tempoLimite then
                    pontuacao = pontuacao + 100
                else
                    pontuacao = pontuacao + math.floor(pontos)
                end
            end
        end
    end
end

function transicao()
    MenuJogo.trAtivado = true
end

function trocarPergunta()
    Perguntas.index = Perguntas.index + 1
    for i, pergunta in ipairs(Perguntas.lista) do
        if pergunta.ativo then
            if Perguntas.index <= #Perguntas.lista then
                ClockNum.seg = Perguntas.lista[Perguntas.index].temp
                Clock.color = green
            else
                -- "Load do Menu Vitoria"
                ativaMenuVitoria()
                Comp.pontuacao.posX = 600 + fonte48n:getWidth(tostring(pontuacao)) / 2
                Comp.pontuacao.posY = 381

                local segundos = math.floor(tempoResposta)
                local texto

                if segundos < 60 then
                    texto = tostring(segundos) .. "s"
                    Comp.tempoResposta.posX = 540 - fonte48n:getWidth(texto) / 2
                else
                    local minutos = math.floor(segundos / 60)
                    local restoSegundos = segundos % 60
                    texto = string.format("%dm %ds", minutos, restoSegundos)
                    Comp.tempoResposta.posX = 580 - fonte48n:getWidth(texto) / 2 
                end
                Comp.tempoResposta.posY = 547
            end
            break
        end
    end
end
