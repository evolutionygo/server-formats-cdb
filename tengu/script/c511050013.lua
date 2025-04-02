--アフター・グロー (Anime)
--Afterglow (Anime)
--Scripted by Hel
local s,c511050013,alias=GetID()
function c511050013.initial_effect(c)
	alias=c:Alias()
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511050013.target)
	e1:SetOperation(c511050013.activate)
	c:RegisterEffect(e1)
end
c511050013.listed_names={alias}
function c511050013.filter(c)
	return c:IsCode(alias) and c:IsAbleToRemove()
end
function c511050013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeck() end
	local g=Duel.GetMatchingGroup(c511050013.filter,tp,LOCATION_DECK,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,tp,LOCATION_SZONE)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,#g,tp,LOCATION_DECK)
end
function c511050013.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(Duel.GetMatchingGroup(c511050013.filter,tp,LOCATION_DECK,0,nil),POS_FACEUP,REASON_EFFECT)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.BreakEffect()
		local c=e:GetHandler()
		c:CancelToGrave()
		Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringc511050013(c511050013,0))
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DRAW)
		e1:SetCondition(c511050013.con)
		e1:SetOperation(c511050013.op)
		e1:SetOwnerPlayer(tp)
		if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_DRAW then
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN+RESET_EVENT+RESETS_STANDARD-RESET_TOHAND,2)
		else
			e1:SetLabel(0)
			e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN+RESET_EVENT+RESETS_STANDARD-RESET_TOHAND)
		end
		c:RegisterEffect(e1)
	end
end
function c511050013.con(e,tp,eg,ep,ev,re,r,rp)
	return ep==e:GetOwnerPlayer() and Duel.GetTurnPlayer()==e:GetOwnerPlayer()
		and Duel.GetCurrentPhase()==PHASE_DRAW and Duel.GetTurnCount()~=e:GetLabel()
end
function c511050013.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectEffectYesNo(tp,e:GetHandler()) then
		Duel.Hint(HINT_CARD,0,c511050013)
		Duel.ConfirmCards(1-tp,e:GetHandler())
		Duel.Damage(1-tp,4000,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
end