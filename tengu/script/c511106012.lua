--分断の壁
--Wall of Disruption (Anime)
--scripted by Hatter
function c511106012.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511106012.activate)
	c:RegisterEffect(e1)
end
function c511106012.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c511106012.atkcon)
	e1:SetOperation(c511106012.atkop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511106012.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	return tc:IsControler(1-tp) or (bc and bc:IsControler(1-tp))
end
function c511106012.atkop(e,tp,eg,ep,ev,re,r,rp)
	local atk=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)*800
	if atk==0 then return end
	local g=Group.CreateGroup()
	local ac,dc=Duel.GetAttacker(),Duel.GetAttackTarget()
	if ac and ac:IsControler(1-tp) then
		g:AddCard(ac)
	end
	if dc and dc:IsControler(1-tp) then
		g:AddCard(dc)
	end
	if #g==0 then return end
	for tc in g:Iter() do
		--Decrease ATK
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end