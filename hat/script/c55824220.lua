--輝石融合
--Pyroxene Fusion
function c55824220.initial_effect(c)
	--Activate
	c:RegisterEffect(Fusion.CreateSummonEff(c,aux.FilterBoolFunction(Card.IsSetCard,0x1047)))
end
c55824220.listed_series={0x1047}