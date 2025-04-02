--ダーク・コーリング
--Dark Calling
function c12071500.initial_effect(c)
	--Activate
	local e1=Fusion.CreateSummonEff{handler=c,fusfilter=c12071500.fusfilter,matfilter=Fusion.InHandMat(Card.IsAbleToRemove),
									extrafil=c12071500.fextra,extraop=Fusion.BanishMaterial,extratg=c12071500.extratg,chkf=FUSPROC_NOLIMIT}
	c:RegisterEffect(e1)
end
c12071500.listed_names={CARD_DARK_FUSION}
function c12071500.fusfilter(c)
	return c.dark_calling
end
function c12071500.fextra(e,tp,mg)
	return Duel.GetMatchingGroup(Fusion.IsMonsterFilter(Card.IsAbleToRemove),tp,LOCATION_GRAVE+LOCATION_HAND,0,nil)
end
function c12071500.extratg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end