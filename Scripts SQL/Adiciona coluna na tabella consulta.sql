
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Consulta_Dashboard]') AND type in (N'U'))
DROP TABLE [dbo].[Consulta_Dashboard]
GO
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Consulta_Dashboard (
	CON_id INT PRIMARY KEY IDENTITY(13,1) NOT NULL,
	CON_titulo VARCHAR (50) NULL,
	CON_sql TEXT NULL,
	CON_javascript TEXT NULL,
	CON_dataCriacao DateTime Default GetDate(),
	CON_dataAlteracao DateTime Default GetDate()
)
GO

insert into Consulta_Dashboard (CON_titulo,CON_sql,CON_javascript) values('Consulta padrão','-- Escreva seu código aqui :)

select Emissao,TotVal 
from notas
where status=''F''
order by Emissao asc','
var opcoes = {
    theme: "light2",
    exportEnabled: true,
    title: {
        text: "Faturamento X Mês"
    },
    culture: ''ptbr'',
    charts: [{
        //height: 100,
        toolTip: {
            shared: true
        },
        axisX: {
            labelFormatter: function(e) {
                return CanvasJS.formatDate(e.value, "DD MMM");
            },
            labelAngle: -20
        },
        axisY: {
            prefix: "R$ ",
            tickLength: 0,
            labelFormatter: addSymbols,
        },
        legend: {
            verticalAlign: "top"
        },
        data: [{
            showInLegend: true,
            yValueFormatString: "R$ #,###.##",
            dataPoints: dados, // Dados são obtidos diretamente da consulta em forma de JSON
            valueFormatString: "DD-MMM"
        }]
    }],
    rangeSelector: {
        selectedRangeButtonIndex: 0,
        inputFields: {
            //startValue: 4000,
            //endValue: 6000,
            valueFormatString: "DD-MMM-YYYY"
        },
        buttons: [{
            label: "1M",
            range: 1,
            rangeType: "month"
        }, {
            label: "3M",
            range: 3,
            rangeType: "month"
        }, {
            label: "6M",
            range: 6,
            rangeType: "month"
        }, {
            label: "1A",
            range: 1,
            rangeType: "year"
        }, {
            label: "Tudo",
            range: null,
            rangeType: "all"
        }],
        buttonStyle: {
            backgroundColorOnHover: "#6b5b95",
            backgroundColorOnSelect: "#6b5b95"
        }
    }
}
/**
 *    Vc pode pegar a variável dados que virá com a informação do banco e tratar 
 * através do FOR abaixo, onde vc trás o JSON e trata ele como data ou como número
 */

if (consulta_personalizada.length > 0) {
    for (var i = 0; i < consulta_personalizada.length; i++) {
        dados.push({
            x: new Date(consulta_personalizada[i].Emissao),
            y: Number(consulta_personalizada[i].TotVal)
        });
    }
}
// Essa função chama o gráfico e passa as opções
$("#grafico").CanvasJSStockChart(opcoes);
/**
 * Essa função encurta os valores como por exemplo 1000.000 = 1M
 */
function addSymbols(e) {
    var suffixes = ["", "K", "M", "B"];
    var order = Math.max(Math.floor(Math.log(e.value) / Math.log(1000)), 0);
    if (order > suffixes.length - 1)
        order = suffixes.length - 1;
    var suffix = suffixes[order];
    return CanvasJS.formatNumber(e.value / Math.pow(1000, order)) + suffix;
}
');
insert into Consulta_Dashboard (CON_titulo,CON_sql,CON_javascript) values('Teste de consulta','-- Escreva seu código aqui :)

select Emissao,TotVal 
from notas
where status=''F''
order by Emissao asc','window.onload = function () {

var chart = new CanvasJS.Chart("grafico", {
	animationEnabled: true,
	exportEnabled: true,
	theme: "light1", // "light1", "light2", "dark1", "dark2"
	zoomEnabled: true,
	title:{
		text: "Simple Column Chart with Index Labels"
	},
  	axisY: {
      includeZero: true
    },
	data: [{
		type: "column", //change type to bar, line, area, pie, etc
		//indexLabel: "{y}", //Shows y value on all Data Points
		indexLabelFontColor: "#5A5757",
      	indexLabelFontSize: 16,
		indexLabelPlacement: "outside",
		dataPoints: dados
	}]
});

for(i=0; i<consulta_personalizada.length;i++){
	dados.push({
		x: new Date(consulta_personalizada[i].Emissao),
		y: Number(consulta_personalizada[i].TotVal)
	});
}

chart.render();

}');
insert into Consulta_Dashboard (CON_titulo,CON_sql,CON_javascript) values('Consulta nova','select Emissao,TotVal 
from notas
where status=''F''
order by Emissao asc','window.onload = function () {

// grafico
var chart = new CanvasJS.Chart("grafico", {
	animationEnabled: true,
	zoomEnabled: true,
	title:{
		text: "Daily High Temperature at Different Beaches"
	},
	axisX: {
		valueFormatString: "DD MMM,YY"
	},
	axisY: {
		title: "Temperature (in °C)",
		suffix: " °C"
	},
	legend:{
		cursor: "pointer",
		fontSize: 16,
		itemclick: toggleDataSeries
	},
	toolTip:{
		shared: true
	},
	data: [{
		name: "Myrtle Beach",
		type: "spline",
		yValueFormatString: "#0.## °C",
		showInLegend: true,
		dataPoints: dados // dados tratados
	}]
});

// dados brutos da consulta sql
// consulta_personalizada
for(i=0; i< consulta_personalizada.length; i++){
	dados.push({
		x: new Date(consulta_personalizada[i].Emissao),
		y: Number(consulta_personalizada[i].TotVal)
	});
}

chart.render();

function toggleDataSeries(e){
	if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	}
	else{
		e.dataSeries.visible = true;
	}
	chart.render();
}

}');



select * from Consulta_Dashboard
