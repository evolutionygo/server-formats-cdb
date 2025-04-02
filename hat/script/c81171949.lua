--ジャックポット7
--Jackpot 7
function c81171949.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c81171949.target)
	e1:SetOperation(c81171949.activate)
	c:RegisterEffect(e1)
	--Banish itself
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc81171949(c81171949,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c81171949.rmcon)
	e2:SetTarget(c81171949.rmtg)
	e2:SetOperation(c81171949.rmop)
	c:RegisterEffect(e2)
end
c81171949.listed_names={c81171949}
function c81171949.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) end
end
function c81171949.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		c:CancelToGrave()
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
	end
end
function c81171949.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local prev=c:GetPreviousControler()
	return prev==c:GetControler() and rp==1-prev and r&REASON_EFFECT~=0 and r&REASON_RETURN==0
end
function c81171949.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
end
function c81171949.filter(c)
	return c:IsCode(c81171949) and c:HasFlagEffect(c81171949)
end
function c81171949.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and not Duel.IsPlayerAffectedByEffect(c:GetControler(),CARD_SPIRIT_ELIMINATION) and Duel.Remove(c,POS_FACEUP,REASON_EFFECT)~=0 then
		c:RegisterFlagEffect(c81171949,RESET_EVENT|RESETS_STANDARD,0,0)
		if Duel.IsExistingMatchingCard(c81171949.filter,tp,LOCATION_REMOVED,0,3,nil) then
			Duel.Win(tp,WIN_REASON_JACKPOT7)
		end
	end
end