--ミラクル・コンタクト (Anime)
--Miracle Contact (Anime)
--Scripted by Larry126
function c511600380.initial_effect(c)
	--Activate
	local e1=Fusion.CreateSummonEff(c,c511600380.spfilter,Fusion.OnFieldMat(Card.IsAbleToDeck),c511600380.fextra,Fusion.ShuffleMaterial,nil,nil,nil,SUMMON_TYPE_FUSION|MATERIAL_FUSION,nil,FUSPROC_NOTFUSION,nil,nil,nil,c511600380.extratg)
	c:RegisterEffect(e1)
end
c511600380.listed_series={0x3008}
c511600380.listed_names={CARD_NEOS}
function c511600380.spfilter(c)
	return c:IsSetCard(0x3008) and c:ListsCodeAsMaterial(CARD_NEOS)
end
function c511600380.fextra(e,tp,mg)
	return Duel.GetMatchingGroup(aux.NecroValleyFilter(Fusion.IsMonsterFilter(Card.IsAbleToDeck)),tp,LOCATION_GRAVE,0,nil)
end
function c511600380.extratg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_ONFIELD+LOCATION_GRAVE)
end