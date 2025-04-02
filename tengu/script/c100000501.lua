--幻影融合
--Vision Fusion (Manga)
function c100000501.initial_effect(c)
	local e1=Fusion.CreateSummonEff(c,aux.FilterBoolFunction(Card.IsSetCard,0x5008),aux.FALSE,c100000501.fextra,nil,nil,nil,2)
	c:RegisterEffect(e1)
end
c100000501.listed_series={0x5008}
function c100000501.mfilter(c)
	return c:IsAbleToGrave() and c:IsFaceup() and c:IsSetCard(0x5008)
end
function c100000501.fextra(e,tp,mg)
	return Duel.GetMatchingGroup(c100000501.mfilter,tp,LOCATION_SZONE,0,nil)
end