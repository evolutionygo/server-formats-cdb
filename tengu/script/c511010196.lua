--ＣＮｏ.９６ ブラック・ストーム (Anime)
--Number C96: Dark Storm (Anime)
--fixed by MLD
Duel.LoadCardScript("c77205367.lua")
function c511010196.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_DARK),3,4)
	c:EnableReviveLimit()
	--Rank Up Check
	aux.EnableCheckRankUp(c,nil,nil,55727845)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,SET_NUMBER)))
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c511010196.damop)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511010196(c511010196,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(aux.dxmcostgen(1,1,nil))
	e3:SetTarget(c511010196.atktg)
	e3:SetOperation(c511010196.atkop)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_RANKUP_EFFECT)
	e4:SetLabelObject(e3)
	c:RegisterEffect(e4,false,REGISTER_FLAG_DETACH_XMAT)
end
c511010196.listed_series={SET_NUMBER}
c511010196.listed_names={55727845}
c511010196.aux.xyz_number=96
function c511010196.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:GetAttack()>0 and c:GetFlagEffect(c511010196)==0 end
	c:RegisterFlagEffect(c511010196,RESET_PHASE+PHASE_DAMAGE,0,0)
	Duel.SetTargetCard(bc)
end
function c511010196.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetAttack()>0 then
		local atk=tc:GetAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e2)
	end
end
function c511010196.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not c:IsHasEffect(EFFECT_TO_GRAVE_REDIRECT) and bc then
		if c:IsHasEffect(EFFECT_INDESTRUCTABLE_BATTLE) then
			local tcind={c:GetCardEffect(EFFECT_INDESTRUCTABLE_BATTLE)}
			for i=1,#tcind do
				local te=tcind[i]
				local f=te:GetValue()
				if type(f)=='function' then
					if f(te,bc) then return end
				else return end
			end
		end
		local a=Duel.GetAttacker()
		local d=Duel.GetAttackTarget()
		local chk=false
		if d~=c then a,d=d,a end
		if a:IsPosition(POS_FACEUP_DEFENSE) then
			if not a:IsHasEffect(EFFECT_DEFENSE_ATTACK) then return end
			if a:IsHasEffect(75372290) then
				if d:IsAttackPos() then
					if a:GetDefense()==d:GetAttack() then
						chk=a:GetDefense()~=0
					else
						chk=a:GetDefense()>=d:GetAttack()
					end
				else
					chk=a:GetDefense()>d:GetDefense()
				end
			else
				if d:IsAttackPos() then
					if a:GetAttack()==d:GetAttack() then
						chk=a:GetAttack()~=0
					else
						chk=a:GetAttack()>=d:GetAttack()
					end
				else
					chk=a:GetAttack()>d:GetDefense()
				end
			end
		else
			if d:IsAttackPos() then
				if a:GetAttack()==d:GetAttack() then
					chk=a:GetAttack()~=0
				else
					chk=a:GetAttack()>=d:GetAttack()
				end
			else
				chk=a:GetAttack()>d:GetDefense()
			end
		end
		if chk then
			Duel.ChangeBattleDamage(1-ep,ev,false)
		end
	end
end