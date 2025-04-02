--遺言状
--Last Will (GOAT)
function c504700147.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c504700147.activate)
	c:RegisterEffect(e1)
end
function c504700147.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c504700147.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetOperation(c504700147.checkop)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CUSTOM+c504700147)
	e2:SetCountLimit(1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetCondition(c504700147.checkcon)
	e2:SetOperation(c504700147.checkop2)
	Duel.RegisterEffect(e2,tp)
end
function c504700147.spfilter(c,e,tp)
	return c:IsAttackBelow(1500) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c504700147.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c504700147.cfilter,1,nil,tp) then
		Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+c504700147,e,0,0,0,0)
		e:Reset()
	end
end
function c504700147.checkcon(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler()==e:GetHandler()
end
function c504700147.checkop2(e,tp,eg,ep,ev,re,r,rp)
	e:Reset()
	if Duel.SelectYesNo(tp,aux.Stringc504700147(c504700147,0)) then
		Duel.Hint(HINT_CARD,0,c504700147)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c504700147.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if #g==0 then
			Duel.GoatConfirm(tp,LOCATION_DECK)
		else
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end