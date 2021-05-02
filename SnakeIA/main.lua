success = love.window.setMode( 800, 800, flags)

function love.load()

    -- Instancia de tudo
    tryagain2 = love.graphics.newImage("img/tryagain2.png")
    sairImg = love.graphics.newImage("img/sair.png")
    btnHumano = love.graphics.newImage("img/button1.png")
    btnBFS = love.graphics.newImage("img/button2.png")
    btnDFS = love.graphics.newImage("img/button3.png")
    fundoBranco = love.graphics.newImage("img/fundoBranco.jpg")
    xMouse = 0
    yMouse = 0
    xMouse2 = 0
    yMouse2 = 0
    xMouse3 = 0
    yMouse3 = 0
    down = false
    down2 = false
    down3 = false
    Pontuacao = 0

    x1,y1 = 0,0;
    x, y = 400, 400
    tamanho = 16;
    delay = 1;
    direcao = 1;
    pause = false;
    pauseImg = love.graphics.newImage("img/png.png")
    gameoverImg = love.graphics.newImage("img/go.png")
    perdeu = false;
    indicaqueperdeu = false;
    quant = 1;
    direcaoString = "";
    xMaca = 0
    yMaca = 0
    MacaOK = false;
    isDourado = false;
    tempo = 0.05
    timer = 0;
    inicio = true;
    jogador = 0;
    
    isRestart = false

    Quadrado = love.graphics.newImage("img/ImgQuadrado.png")

    umoudois = 0;

    ordem = 1;

end

--Tecla pressionada

function love.keypressed(tecla)
    if(tecla == "down") then
        direcao = 1;
    elseif(tecla == "right") then
        direcao = 2;
    elseif(tecla == "up") then
        direcao = 3;
    elseif(tecla == "left") then
        direcao = 4;
    elseif(tecla == "escape") then
        if(pause == true) then
            pause = false
        else
            pause = true
        end
    end

    

end

-- CADA FRAME

function love.update()


    --Recomeçar

    if(isRestart == true) then
        salvaJogador = 0;
        if((jogador == 1) or (jogador == 2) or (jogador == 3)) then
            salvaJogador = jogador
        end
        love.load()
        jogador = salvaJogador
    end

    if((pause == false) and (perdeu == false) and (inicio == false)) then

        timer = timer + love.timer.getDelta()

        if((x > 768) or (x < 16) or (y > 768) or (y < 16)) then
            indicaqueperdeu = true
        end

            --Direção


            if(jogador == 1) then
                if(direcao == 1) then
                    direcaoString = "up"
                elseif(direcao == 2) then
                    direcaoString = "left"
                elseif(direcao == 3) then
                     direcaoString = "down"
                elseif(direcao == 4) then
                     direcaoString = "right"
                end
            end

            if(jogador == 2) then
                num = math.random (1,4)
                if(num == 1) then
                    direcaoString = "right"
                    if(x == 16) then
                        direcaoString = "left"
                    end
                elseif(num == 2) then
                    direcaoString = "left"
                    if(x == 768) then
                        direcaoString = "right"
                    end
                elseif(num == 3) then
                    direcaoString = "down"
                    if(y == 16) then
                        direcaoString = "up"
                    end
                elseif(num == 4) then
                    direcaoString = "up"
                    if(y == 768) then
                        direcaoString = "down"
                    end
                else
                    direcaoString = "right"
                end
            end

            if(jogador == 3) then
                if(xMaca < x) then
                    direcaoString = "right"
                elseif(xMaca > x)then
                    direcaoString = "left"
                elseif(yMaca < y)then
                    direcaoString = "down"
                elseif(yMaca > y)then
                    direcaoString = "up"
                else
                    direcaoString = "right"
                end
            end


            --Spawn maça

            if (MacaOK == false) then
                xMaca = (math.random (47)) * 16;
                yMaca = (math.random (47)) * 16;
                MacaOK = true;
            end

            down = love.mouse.isDown(1)
            if(down == true)then 
                xMouse = love.mouse.getX()
                yMouse = love.mouse.getY()
            end
        end
        

end

-- Representar a tela

function love.draw()

    
    if(inicio == false) then

        if (pause == true) then
            love.graphics.setColor(1,1,1)
            love.graphics.draw(pauseImg, 150,150)
        end

        if (indicaqueperdeu == true) then
            love.graphics.setColor(1,1,1)
            love.graphics.draw(gameoverImg, 150,150)
            love.graphics.draw(tryagain2, 150,580)
            love.graphics.setColor(1,1,1)
            love.graphics.draw(sairImg,670,686)

            love.graphics.print("Pontuação = ", 330 , 50,0,1.5,1.25)
            love.graphics.print(math.floor(Pontuacao), 460 , 50,0,1.5,1.25)

            down2 = love.mouse.isDown(1)
                if(down2 == true)then 
                    xMouse2 = love.mouse.getX()
                    yMouse2 = love.mouse.getY()

                    if((xMouse2 > 150) and (xMouse2 < 650 ) and (yMouse2 > 580) and (yMouse2 < 780)) then
                        isRestart = true;
                    elseif((xMouse2 > 670) and (xMouse2 < 764 ) and (yMouse2 > 686) and (yMouse2 < 780))then
                        love.event.quit()
                    end
                end
            perdeu = true;
        end

        love.graphics.setColor(255,0,0)
        love.graphics.rectangle("fill", 0 ,0 ,800,16)
        love.graphics.rectangle("fill", 0 ,0 ,16,800)
        love.graphics.rectangle("fill", 784 ,0 ,16,800)
        love.graphics.rectangle("fill", 0 ,784 ,800,16)


        love.graphics.setColor(1,1,1)


        --Andar o quadrado

        if((pause == false) and (perdeu == false)) then
            if(timer >= tempo) then


                x1,y1 = x,y
            
                if( direcaoString == "up") then
                    y = y+tamanho
                elseif(direcaoString == "right") then
                    x = x-tamanho
                elseif(direcaoString == "down") then
                    y = y-tamanho
                elseif(direcaoString == "left") then
                    x = x+tamanho
                end 

                timer = 0
            end

            love.graphics.setColor(0,0,255)
            love.graphics.rectangle("fill", x, y, tamanho, tamanho )
            love.graphics.setColor(1,1,1)
            love.graphics.rectangle("fill", x1, y1, tamanho, tamanho )

            if(MacaOK == true)then
                love.graphics.setColor(255,255,0)
                love.graphics.rectangle("fill", xMaca, yMaca, tamanho, tamanho )
            end

            if((x == xMaca) and(y == yMaca))then
                MacaOK = false;

                Pontuacao = Pontuacao +1

                ordem = ordem +1
            end
                love.graphics.print("Pontuação = ", 400 , 0,0,1.5,1.25)
                love.graphics.print(math.floor(Pontuacao), 530 , 0,0,1.5,1.25)
        end
    
    elseif(inicio == true) then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(fundoBranco, 200,200)

        love.graphics.setColor(1,1,1)
        love.graphics.draw(btnHumano, 300,300)
        love.graphics.setColor(1,1,1)
        love.graphics.draw(btnBFS, 300,400)
        love.graphics.setColor(1,1,1)
        love.graphics.draw(btnDFS, 300,500)


        down3 = love.mouse.isDown(1)
        if(down3 == true)then 
            xMouse3 = love.mouse.getX()
            yMouse3 = love.mouse.getY()

            if((xMouse3 > 300) and (xMouse3 < 500 ) and (yMouse3 > 300) and (yMouse3 < 350)) then
                jogador = 1
            elseif((xMouse3 > 300) and (xMouse3 < 500 ) and (yMouse3 > 400) and (yMouse3 < 450)) then
                jogador = 2
            elseif((xMouse3 > 300) and (xMouse3 < 500 ) and (yMouse3 > 500) and (yMouse3 < 550)) then
                jogador = 3
            end
            inicio = false
        end
    end


end
