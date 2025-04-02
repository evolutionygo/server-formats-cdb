--パペット・キング
--Puppet King
function c3167573.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc3167573(c3167573,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TOHAND_CONFIRM)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c3167573.spcon)
	e1:SetTarget(c3167573.sptg)
	e1:SetOperation(c3167573.spop)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc3167573(c3167573,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c3167573.descon)
	e2:SetOperation(c3167573.desop)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c3167573.cfilter(c,tp)
	return c:IsControler(1-tp) and c:IsPreviousLocation(LOCATION_DECK) and not c:IsReason(REASON_DRAW)
		and c:IsMonster() and c:IsPreviousControler(1-tp)
end
function c3167573.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c3167573.cfilter,1,nil,tp)
end
function c3167573.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c3167573.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local des_eff=e:GetLabelObject()
		local ct=Duel.IsTurnPlayer(tp) and 2 or 1
		c:RegisterFlagEffect(c3167573,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,ct)
		des_eff:SetLabel(Duel.GetTurnCount()+ct)
	end
end
function c3167573.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(c3167573)>0 and Duel.GetTurnCount()==e:GetLabel()
end
function c3167573.desop(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(0)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end