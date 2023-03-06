defmodule Ahorcado do


  @palabras ["elefante", "rinoceronte", "otorrinolaringologo", "idiosincracia", "sofkianos", "arquitectura", "lewandowski", "electrocardiograma", "hipopotamo"]
  #


  def obtener_palabra() do
    Enum.random(@palabras)
  end


  def jugar do


    palabra = obtener_palabra()
    letras_adivinadas = []
    intentos_restantes = 7


    :timer.sleep(1000)
    IO.puts(" ")
    IO.puts("----------------------------------------------------BIENVENIDO AL JUEGO------------------------------------------------------------------")
    IO.puts(" ")
    :timer.sleep(3000)
    IO.puts("La palabra que debes adivinar tiene #{String.length(palabra)} letras.")
    :timer.sleep(2000)



    juego(palabra, letras_adivinadas, intentos_restantes)

  end

  defp obtener_letra() do
    IO.puts("Ingresa una letra:")
    input = IO.gets("") |> String.trim()

    case String.codepoints(input) do
      [letra] when letra in ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z) ->
        letra
        _ ->


      IO.puts("No ingresaste una letra, Por favor ingresa una letra valida.")
      obtener_letra()

    end
  end


  defp mostrar_palabra(palabra, letras_adivinadas) do
    primera_letra = String.first(palabra)
    ultima_letra = String.last(palabra)

    medio_palabra = palabra |> String.slice(1..-2)

    letras_mostradas = for letra <- String.codepoints(medio_palabra) do
      if Enum.member?(letras_adivinadas, letra) do
        letra
      else
        "_"
      end
    end

    IO.puts("#{primera_letra} #{Enum.join(letras_mostradas, " ")} #{ultima_letra}")
  end

  def palabra_adivinada?(palabra, letras_adivinadas) do
  palabra
  |> String.graphemes()
  |> Enum.uniq()
  |> Enum.all?(fn letra -> Enum.member?(letras_adivinadas, letra) end)
  end

  def juego(palabra, _, intentos_restantes) when intentos_restantes == 0 do
      perder_juego(palabra)

  end


  def juego(palabra, letras_adivinadas, intentos_restantes) do

     IO.puts(" ")
    mostrar_palabra(palabra, letras_adivinadas)


    case obtener_letra() do
      letra ->
        case String.contains?(palabra, letra) do
          true ->
            letras_adivinadas = [letra | letras_adivinadas]
            dibujar_ahorcado(intentos_restantes)
            if palabra_adivinada?(palabra, letras_adivinadas) do
              ganar_juego(palabra)
            else
              IO.puts("La letra '#{letra}' esta en la palabra.")
              juego(palabra, letras_adivinadas, intentos_restantes)

            end

          false ->
            intentos_restantes = intentos_restantes - 1
            dibujar_ahorcado(intentos_restantes)
            IO.puts("La letra '#{letra}' no esta en la palabra. Te quedan #{intentos_restantes} intentos.")
            juego(palabra, letras_adivinadas, intentos_restantes)

            end
       end
  end



  defp dibujar_ahorcado(intentos_restantes) do
    case intentos_restantes do

       8 -> IO.puts("""

           G A N A S T E ---- G A N A S T E ----- G A N A S T E


                                 _ ( ) _
                                  \\ | /
                                    |
                                   / \\
                                  /   \\
       ==========================================================================
    """)

      #------------------------------------------------------------------------------------------------------------
      7 -> IO.puts("""
                _______________
               |     _______   |
               |____|       |  |
                            |  |
                            |  |
                            |  |
                            |  |
                            |  |
                            |  |
                            |  |
        ========================================
    """)
      #------------------------------------------------------------------------------------------------------------
    6 -> IO.puts("""
                _______________
               |     _______   |
               |____|       |  |
                 |          |  |
                            |  |
                            |  |
                            |  |
                            |  |
                            |  |
                            |  |
        ========================================
    """)
      #------------------------------------------------------------------------------------------------------------
    5 -> IO.puts("""
                _______________
               |     _______   |
               |____|       |  |
                 |          |  |
                ( )         |  |
                            |  |
                            |  |
                            |  |
                            |  |
                            |  |
        ========================================
    """)

     #------------------------------------------------------------------------------------------------------------
     4 -> IO.puts("""
                _______________
               |     _______   |
               |____|       |  |
                 |          |  |
                ( )         |  |
                 |          |  |
                 |          |  |
                            |  |
                            |  |
                            |  |
        ========================================
    """)

    #------------------------------------------------------------------------------------------------------------
    3 -> IO.puts("""
                _______________
               |     _______   |
               |____|       |  |
                 |          |  |
                ( )         |  |
                 |          |  |
                 |          |  |
                  \\         |  |
                   \\        |  |
                            |  |
        ========================================
    """)

     #------------------------------------------------------------------------------------------------------------
     2 -> IO.puts("""
                _______________
               |     _______   |
               |____|       |  |
                 |          |  |
                ( )         |  |
                 |          |  |
                 |          |  |
                / \\         |  |
               /   \\        |  |
                            |  |
        ========================================
    """)

  #------------------------------------------------------------------------------------------------------------
  1 -> IO.puts("""
                _______________
               |     _______   |
               |____|       |  |
                 |          |  |
                ( ) _       |  |
                 | /        |  |
                 |          |  |
                / \\         |  |
               /   \\        |  |
                            |  |
        ========================================
    """)

   #------------------------------------------------------------------------------------------------------------
  0 -> IO.puts("""

                _______________
               |    AHORCADO   |             GAME OVER
               |____|       |  |             GAME OVER
                 |          |  |             GAME OVER
              _ ( ) _       |  |             GAME OVER
               \\ | /        |  |             GAME OVER   A H O R C A D O ---- A H O R C A D O ---- A H O R C A D O ----
                 |          |  |             GAME OVER
                / \\         |  |             GAME OVER
               /   \\        |  |             GAME OVER
                            |  |             GAME OVER
        ========================================
    """)


        end
  end


  def ganar_juego(palabra) do
    IO.puts("FELICITACIONES!!!! HAS ADIVINADO LA PALABRA! La palabra es '#{palabra}'.")
    :timer.sleep(1500)
    dibujar_ahorcado(8)
    :timer.sleep(3000)
  end



  def perder_juego(palabra) do
    IO.puts(" ")
    :timer.sleep(1500)
    IO.puts("GAME OVER! Has perdido el juego. La palabra era '#{palabra}'.")
    :timer.sleep(1500)
  end












end
