--Ａｉラブ融合 (Anime)
--A.I. Love Fusion (Anime)
--Scripted by Larry126
function c511600306.initial_effect(c)
	local e1=Fusion.CreateSummonEff(c,aux.FilterBoolFunction(Card.IsSetCard,0x135),nil,c511600306.fextra)
	c:RegisterEffect(e1)
end
c511600306.listed_series={0x135}
function c511600306.filter(c,e)
	return c:IsFaceup() and c:IsLinkMonster() and c:IsAbleToGrave() and c:IsAttribute(ATTRIBUTE_EARTH) and not c:IsImmuneToEffect(e) 
end
function c511600306.fcheck(tp,sg,fc)
	return sg:FilterCount(Card.IsControler,nil,1-tp)<=1
end
function c511600306.fextra(e,tp,mg)
	local g=Duel.GetMatchingGroup(c511600306.filter,tp,0,LOCATION_MZONE,nil,e)
	if g and #g>0 then
			return g,c511600306.fcheck
	end
	return nil
end