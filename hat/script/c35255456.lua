--ミラクル・コンタクト
--Miracle Contact
function c35255456.initial_effect(c)
	--Activate
	c:RegisterEffect(Fusion.CreateSummonEff(c,c35255456.spfilter,Card.IsAbleToDeck,c35255456.fextra,Fusion.ShuffleMaterial,nil,nil,nil,0,nil,FUSPROC_NOTFUSION|FUSPROC_LISTEDMATS))
end
c35255456.listed_series={0x3008}
c35255456.listed_names={CARD_NEOS}
function c35255456.spfilter(c)
	return c:IsSetCard(0x3008) and c:ListsCodeAsMaterial(CARD_NEOS)
end
function c35255456.fextra(e,tp,mg)
	return Duel.GetMatchingGroup(aux.NecroValleyFilter(Fusion.IsMonsterFilter(Card.IsAbleToDeck)),tp,LOCATION_GRAVE,0,nil)
end