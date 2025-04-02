--高等儀式術
function c46052429.initial_effect(c)
	local e1=Ritual.CreateProc({handler=c,lvtype=RITPROC_EQUAL,extrafil=c46052429.extrafil,extraop=c46052429.extraop,matfilter=c46052429.forcedgroup})
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	c:RegisterEffect(e1)
end
function c46052429.extrafil(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.GetFieldGroup(tp,LOCATION_DECK,0)
end
function c46052429.extraop(mat,e,tp,eg,ep,ev,re,r,rp,tc)
	return Duel.SendtoGrave(mat,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
end
function c46052429.forcedgroup(c,e,tp)
	return c:IsLocation(LOCATION_DECK) and c:IsType(TYPE_NORMAL) and c:IsAbleToGrave()
end