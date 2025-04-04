--エンシェント・フェアリー・ドラゴン (Pre-Errata)
--Ancient Fairy Dragon (Pre-Errata)
function c25862691.initial_effect(c)
	c:EnableReviveLimit()
	--Synchro Summon procedure
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(nil),1,99)
	--Special Summon 1 Level 4 or lower monster from your hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc25862691(c25862691,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(function() return Duel.GetCurrentPhase()==PHASE_MAIN1 end)
	e1:SetCost(c25862691.spcost)
	e1:SetTarget(c25862691.sptg)
	e1:SetOperation(c25862691.spop)
	c:RegisterEffect(e1)
	--Destroy Field Spells and gain LP
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc25862691(c25862691,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_RECOVER+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c25862691.destg)
	e2:SetOperation(c25862691.desop)
	c:RegisterEffect(e2)
end
function c25862691.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	--Cannot conduct your Battle Phase this turn
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringc25862691(c25862691,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c25862691.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c25862691.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c25862691.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c25862691.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c25862691.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c25862691.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(0,LOCATION_FZONE,LOCATION_FZONE)
	if chk==0 then return #g>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
	Duel.SetPossibleOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c25862691.thfilter(c)
	return c:IsFieldSpell() and c:IsAbleToHand()
end
function c25862691.desop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetFieldGroup(0,LOCATION_FZONE,LOCATION_FZONE)
	if not (#dg>0 and Duel.Destroy(dg,REASON_EFFECT)>0 and Duel.Recover(tp,1000,REASON_EFFECT)>0) then return end
	local hg=Duel.GetMatchingGroup(c25862691.thfilter,tp,LOCATION_DECK,0,nil)
	if #hg>0 and Duel.SelectYesNo(tp,aux.Stringc25862691(c25862691,3)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=hg:Select(tp,1,1,nil)
		Duel.BreakEffect()
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end