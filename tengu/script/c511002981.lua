--Pendulum Fusion (anime)
--rescripted by Naim
function c511002981.initial_effect(c)
	local e1=Fusion.CreateSummonEff(c,nil,aux.FALSE,c511002981.fextra)
	c:RegisterEffect(e1)
end
function c511002981.fextra(e,tp,mg)
	return Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_PZONE,LOCATION_PZONE,nil)
end