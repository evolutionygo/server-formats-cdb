--フュージョン・オブ・ファイア (Anime)
--Fusion of Fire (Anime)
function c511600181.initial_effect(c)
	--Activate
	c:RegisterEffect(Fusion.CreateSummonEff(c,aux.FilterBoolFunction(Card.IsSetCard,0x119),nil,c511600181.fextra))
end
c511600181.listed_series={0x119}
function c511600181.fextra(e,tp,mg)
	return Duel.GetMatchingGroup(Fusion.IsMonsterFilter(Card.IsFaceup),tp,0,LOCATION_ONFIELD,nil)
end