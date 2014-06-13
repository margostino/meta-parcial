require 'rspec'
require '../src/meta-parcial'
require '../src/meta-parcial-12013'

describe 'Practica-Parcial' do

  it 'Eventos sobre objetos que no se le define configuracion no deberia funcionar el trigger' do

    otro_cliente = Cliente.new('Pira',17)
    otra_cuenta = CuentaCorriente.new(otro_cliente,10)

    otra_cuenta.incrementar_saldo_en(55004).should==nil

  end

  it 'Eventos sobre bloques en clases' do

    Configuracion.eventos {
      cuando {saldo < 3000}
      en CuentaCorriente
      ejecutar {cliente.notificarOdio}
      cuando {saldo > 5000}
      en CuentaCorriente
      ejecutar {cliente.notificarAmor}
      cuando {edad == 18}
      en Cliente
      ejecutar {notificarAdultez}
    }

    el_cliente = Cliente.new('Martin',29)
    mi_cuenta = CuentaCorriente.new(el_cliente,10000)

    el_cliente_adulto = Cliente.new('Juan',17)

    mi_cuenta.decrementar_saldo_en(15500).should==el_cliente.notificarOdio
    mi_cuenta.incrementar_saldo_en(1155004).should==el_cliente.notificarAmor

    el_cliente_adulto.cumplirAnios.should==el_cliente_adulto.notificarAdultez
  end

  it 'Eventos sobre objetos' do

    el_cliente = Cliente.new('Juan',17)
    mi_cuenta = CuentaCorriente.new(el_cliente,10000)

    Configuracion.eventos {
      cuando { saldo > 0 }
        en mi_cuenta
          ejecutar { dejarPerseguir() }
    }

    mi_cuenta.incrementar_saldo_en(55004).should==mi_cuenta.dejarPerseguir
  end

  it 'Eventos sobre clases que no se le define configuracion no deberia funcionar el trigger' do

    un_banco=Banco.new
    un_banco.notificar_a_todos.should=='Banco CERRADO'

  end

end