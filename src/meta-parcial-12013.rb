#require '../src/class'

=begin
    Configuracion
      clase1
        eventos
          condicion1-->accion2
          condicion2-->accion2
      clase2
        eventos
          condicion1-->accion
=end

class Configuracion

  def self.clean
    @@event_class=nil
  end

  def self.eventos &bloque
    #@@eventos_de_clase = Array.new
    @@event_class = Hash.new
    self.class_eval &bloque
  end

  def self.cuando &condicion
    @@condicion = condicion
    self
  end

  def self.en clase
    @@clase = clase
    if (@@event_class[@@clase].nil?)
      @@event_class[@@clase]=Array.new
    end

    clase
  end

  def self.crear_trigger
    unless (@@clase.singleton_class.respond_to? :trigger)
      if se_informa_clase?
          @@clase.class_eval do
            def trigger
              @@event_class[self.class].each { |colec_events|
                colec_events.each{ |condicion, accion|
                  if instance_eval &condicion
                    return (instance_eval &accion)
                  end
                }
              }
            end
          end
      else

          @@clase.instance_eval do
            def trigger
              @@event_class[self].each { |colec_events|
                colec_events.each{ |condicion, accion|
                  if instance_eval &condicion
                    return (instance_eval &accion)
                  end
                }
              }
            end
          end
      end
    end
  end

  def self.ejecutar &accion
    evento_para_la_clase = Hash.new
    evento_para_la_clase[@@condicion]=accion
    informar evento_para_la_clase
    crear_trigger
  end

  def self.se_informa_clase?
    @@clase.class==Class
  end

  def self.informar_a_clase evento_para_la_clase
    @@event_class[@@clase] << evento_para_la_clase
    unless @@clase.singleton_class.respond_to? :eventos
      @@clase.singleton_class.send :attr_accessor, :eventos
      @@clase.instance_eval{
        def init_eventos
          @eventos=Array.new
        end
      }
      end


  end

  def self.informar_a_objeto evento_para_la_clase
    @@event_class[@@clase] << evento_para_la_clase
    unless @@clase.singleton_class.respond_to? :eventos
      @@clase.singleton_class.send :attr_accessor, :eventos
      @@clase.instance_eval{
        def init_eventos
          @eventos=Array.new
        end
      }
    end
  end

  def self.informar evento_para_la_clase

    if se_informa_clase?
      informar_a_clase evento_para_la_clase
    else
      informar_a_objeto evento_para_la_clase
    end
  end

end

class Cliente

  attr_accessor :edad, :nombre

  def initialize(nombre,edad)
    @edad = edad
    @nombre = nombre
  end

  def notificarOdio
    'Odio'
  end

  def notificarAmor
    'Amor'
  end

  def notificarHackeo
    'Hackeo'
  end

  def notificarAdultez
    'Es adulto!'
  end

  def cumplirAnios
    @edad = @edad + 1
    return trigger
  end

  def liberar
    'Gracias'
  end

end

module Event_Manager

  def exec_event
    if respond_to? :trigger
      trigger
    end
  end
end

class CuentaCorriente
  include Event_Manager
  attr_accessor :cliente, :saldo#, :eventos

  #@@eventos = Array.new

  def initialize cliente, saldo
    @cliente = cliente
    @saldo = saldo
  end

  def decrementar_saldo_en importe
    @saldo = @saldo - importe
    return exec_event#trigger
  end

  def incrementar_saldo_en importe
    @saldo = @saldo + importe
    return exec_event#trigger
  end

  def dejarPerseguir
    cliente.liberar
  end

end

class Banco
  attr_accessor :cuentas, :clientes

  def notificar_a_todos
    'Banco CERRADO'
  end
end
