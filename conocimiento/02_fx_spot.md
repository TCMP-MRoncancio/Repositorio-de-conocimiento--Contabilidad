# FX Spot

Un FX Spot es la compra o venta de un par de divisas para entrega "inmediata" a una tasa fijada en el contrato. La diapositiva muestra el ciclo T (negociación) → T+1 → T+2 (liquidación y entrega); para efectos contables el plazo no supera 3 días.

En Kondor+ se captura en Deal Capture → Spot Deal: Ccy1/Ccy2, Spot Rate, Amount en cada moneda, Trade Date, Value Date, Folder y Counterparty.

## Ejemplo 1 – Spot CLP-USD T0

Deal 3108228, 16/06/2020: compra de USD 5.000 a 784,50 = CLP 3.922.500, negociada y liquidada el mismo día.

| Evento | Cuenta | Descripción | Moneda | Monto | D/C |
| --- | --- | --- | --- | --- | --- |
| CashFlow | 2115400008060100 | Divisas-Pesos Pend Spot T0 CF | USD | 5.000,00 | Débito |
| CashFlow | 4505417030060100 | Conversión Spot CF | USD | 5.000,00 | Crédito |
| CashFlow | 2505417054050100 | Cambio Spot CF | CLP | 3.922.500,00 | Débito |
| CashFlow | 4115400008000100 | Divisas-Pesos Pend Spot T0 CF | CLP | 3.922.500,00 | Crédito |
| Payment | 2115400008060100 | Divisa-Peso Pend SPT T0 PY | USD | 5.000,00 | Crédito |
| Payment | 1025005001060100 | Depósitos Exterior Spot PY | USD | 5.000,00 | Débito |
| Payment | 4110005001000100 | Pago Efectuado-Recibido SPT PY | CLP | 3.922.500,00 | Crédito |
| Payment | 4115400008000100 | Divisa-Peso Pend SPT T0 PY | CLP | 3.922.500,00 | Débito |

La lógica: el evento CashFlow reconoce el derecho y la obligación pendientes por moneda; el evento Payment los cancela contra la cuenta real de liquidación (depósito en el exterior para USD, pago efectuado para CLP).

## Ejemplo 2 – Spot USD/COP T+n

Deal 3143243, Banco Davivienda, folder TR_FXSPOT: USD 14.000 a 3.900 = COP 54.600.000, negociado el 01/12/2020 con valor el 04/12/2020.

1. Entre negociación y valor se generan **revaluaciones diarias**: valoración en PyG, valoración de la obligación y del derecho en balance (SPT_ValoracionPyG, SPT_ValObligacionBce, SPT_ValDerechoBce).
2. En la fecha valor se **cancelan** derecho y obligación (SPT_CancelDerechoBce, SPT_CancelObligacionBce) y el resultado acumulado queda en PyG.
3. El **pago** se registra con SPT_FormadePago y SPT_CancelCtaPuente en COP y USD (COP 54.600.000 y USD 14.000 a 3.900).
