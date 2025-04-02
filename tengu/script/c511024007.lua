--コーリング・マジック (Anime)
--Spell Calling (Anime)
--Scripted by IanxWaifu
function c511024007.initial_effect(c)
	--Set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511024007(c511024007,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511024007.setcon)
	e1:SetTarget(c511024007.settg)
	e1:SetOperation(c511024007.setop)
	c:RegisterEffect(e1)
end
function c511024007.setcon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and e:GetHandler():IsPreviousControler(tp)
end
function c511024007.filter(c)
	return c:IsSpell() and c:IsSSetable()
end
function c511024007.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>=2
		and Duel.IsExistingMatchingCard(c511024007.filter,tp,LOCATION_DECK,0,2,nil) end
end
function c511024007.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c511024007.filter,tp,LOCATION_DECK,0,2,2,nil)
	if #g>0 then
		Duel.SSet(tp,g)
	end
end