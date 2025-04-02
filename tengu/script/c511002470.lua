--九十九スラッシュ (Manga)
--Tsukumo Slash (Manga)
Duel.EnableUnofficialProc(PROC_STATS_CHANGED)
function c511002470.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002470(c511002470,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(511001762)
	e1:SetCondition(c511002470.condition)
	e1:SetTarget(c511002470.target)
	e1:SetOperation(c511002470.activate)
	c:RegisterEffect(e1)
end
function c511002470.cfilter(c,tp)
	local val=0
	if c:GetFlagEffect(284)>0 then val=c:GetFlagEffectLabel(284) end
	return c:IsFaceup() and c:IsControler(1-tp) and c:GetAttack()~=val
end
function c511002470.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated())
		and eg:IsExists(c511002470.cfilter,1,nil,tp) and Duel.GetLP(tp)<=100
		and Duel.GetLP(1-tp)<=100 and Duel.GetLP(tp)~=Duel.GetLP(1-tp)
end
function c511002470.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
end
function c511002470.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		if Duel.GetLP(tp)>100 or Duel.GetLP(1-tp)>100 or Duel.GetLP(tp)==Duel.GetLP(1-tp) then return end
		local val=0
		if Duel.GetLP(tp)>Duel.GetLP(1-tp) then
			val=Duel.GetLP(tp)-Duel.GetLP(1-tp)
		else
			val=Duel.GetLP(1-tp)-Duel.GetLP(tp)
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		e1:SetValue(val*100)
		tc:RegisterEffect(e1)
	end
end